#' Read a single file from a zip file (into a `data.table`)
#'
#' @param zipfile The Zip file to read from
#' @param filename Filename within Zip file
#' @param schema A list with 'names' and 'read_in_types'. If not provided these types will be automatically generated on reading files.
#' @param allow_missing Fill missing schema columns with NA instead of erroring
#' @param ... Additional arguments to `data.table::fread`
#'
#' Several schemas are included in the package and accessed by passing
#' `dataset_name` and `table_name` to [get_schema()].
#' You can use `get_schema()` with no arguments to list available schemas.
#'
#' You can also construct a custom schema using [create_new_schema()]
#'
#' @returns A `data.table`
#'
#' @import data.table
#' @export
#'
read_file_from_zip <- function(zipfile, filename, schema = NULL, allow_missing = FALSE, ...) {
  if (is.null(schema)) {
    dt_in <- data.table::fread(cmd = sprintf("unzip -p \'%s\' \'%s\'", zipfile, filename), integer64 = "character", ...)

    id_cols <- grep(".*id$", names(dt_in), value = TRUE)

    dt_in[, (id_cols) := lapply(.SD, as.character), .SDcols = id_cols]

    dt_in

  } else {
    con <- unz(zipfile, filename)
    header <- read_header(con)
    close(con)

    present <- subset_schema(schema, header)

    check_missing_columns(setdiff(schema$names, header), filename, allow_missing)

    dt_in <- data.table::fread(
      cmd = sprintf("unzip -p \'%s\' \'%s\'", zipfile, filename),
      colClasses = stats::setNames(present$read_in_types, present$names), ...
    )

    bool_cols <-  present$names[present$read_in_types == "logical"]

    if(!is.null(bool_cols)) {

      dt_in[, (bool_cols) := lapply(.SD, as.logical), .SDcols = bool_cols]

    }

    dt_in
  }

}

#' Open a tsv file or multiple tsv files with a file_tag as an arrow dataset
#'
#' Several schemas are included in the package and accessed by passing
#' `dataset_name` and `table_name` to [get_schema()].
#' You can use `get_schema()` with no arguments to list available schemas.
#'
#' You can also construct a custom schema using [create_new_schema()]
#'
#' @param file_tag "observation", "practice" etc.
#' @param input_dir Directory with tsv files (or in sub-directories)
#' @param schema Optional - an `arrow::Schema` object to set variable types
#' @param allow_missing Leave out missing schema columns instead of erroring
#'
#' @returns An arrow dataset
#'
#' @import arrow
#' @export
read_files_from_tsv <- function(file_tag, input_dir, schema = NULL, allow_missing = FALSE) {

    files_in <- list.files(
      path      = input_dir,
      pattern   = paste0(file_tag, ".*\\.txt$"),
      full.names = TRUE,
      recursive  = TRUE,
      ignore.case = TRUE
    )

  if (!is.null(schema)) {
    headers <- lapply(files_in, read_header)
    header <- headers[[1]]

    differs <- !vapply(headers, identical, logical(1), header)
    if (any(differs)) {
      stop(sprintf("Files have different headers to %s: %s",
                   files_in[1], paste(files_in[differs], collapse = ", ")),
           call. = FALSE)
    }

    check_missing_columns(setdiff(schema$names, header), file_tag, allow_missing)

    files_in |>
      arrow::open_tsv_dataset(schema = subset_schema(schema, header)$arrow_schema, skip = 1)
  }
  else {
    files_in |>
      arrow::open_tsv_dataset()
  }
}


#' Write an arrow dataset to a parquet file
#'
#' @param arrow_data An arrow dataset created from `read_files_from_tsv`
#' @param output_path Output path
#' @param partitioning Optional - variable to partition by
#' @param date_cols Character vector of column names to cast to date
#'
#' @returns the output path
#' @importFrom dplyr compute
#' @import arrow
#' @export
#'
write_arrow_to_parquet <- function(arrow_data, output_path, partitioning = NULL, date_cols = NULL) {

  arrow_data |>
    coerce_date_columns_arrow(date_cols = date_cols) |>
    arrow::write_dataset(output_path, partitioning = partitioning)

  output_path

}


#' Append data frame to parquet
#'
#' Several schemas are included in the package and accessed by passing
#' `dataset_name` and `table_name` to [get_schema()].
#' You can use `get_schema()` with no arguments to list available schemas.
#'
#' You can also construct a custom schema using [create_new_schema()]
#'
#' @param df A data frame
#' @param out_dir Out directory
#' @param table_name "Observation", "Patient" etc.
#' @param data_schema A schema with `names` and `read_in_types`. If not
#'   provided, types are taken from the data frame and any character column
#'   whose name ends in "date" is cast to a date. Missing columns are filled with NA.
#' @param date_format Default "%d/%m/%Y"
#'
#' @returns output directory
#'
#' @import duckdb DBI
#' @export
#'
append_to_parquet <- function(df, out_dir, table_name, data_schema = NULL, date_format = "%d/%m/%Y") {
  con <- DBI::dbConnect(duckdb::duckdb())

  duckdb::duckdb_register(con, "tmp_arrow", df)

  if (is.null(data_schema)) {

    types <- vapply(df, class, character(1))

    date_cols <- grep("date$", names(types)[types == "character"], value = TRUE)

    data_schema <- create_new_schema(
      col_names = names(types),
      col_types = unname(types),
      date_cols = date_cols
    )

  }

  cast_expression <- cast_expression_from_schema(data_schema, table_name, date_format = date_format,
                                                 present_cols = names(df))

  sql <- sprintf(
    "
    COPY (
      SELECT %s
      FROM tmp_arrow
    )
    TO '%s'
    (FORMAT 'parquet', COMPRESSION 'ZSTD', APPEND TRUE, PARTITION_BY ('table'))
  ",
    cast_expression,
    file.path(out_dir, table_name)
  )

  tryCatch(
    DBI::dbExecute(con, sql),
    finally = duckdb::duckdb_unregister(con, "tmp_arrow")
  )

  out_dir
}

#' Return a list of files from within zips which match a pattern
#'
#' `find_files_from_zip` looks inside one zipfile, `find_files_from_zips` looks for all zipfiles in a directory
#'
#' @param root_directory Directory to search
#' @param tag Tag in txt filenames within zips
#' @param zip_file_pattern Pattern zip files must match
#'
#' @returns A named list of txt/tsv files within each zip
#' @export
#'
find_files_from_zips <- function(root_directory, tag, zip_file_pattern = "*.zip$") {

  all_zips <- dir(root_directory, pattern = zip_file_pattern, recursive = TRUE, full.names = TRUE)

  all_files <- lapply(all_zips, \(zipfile) {
    find_files_from_zip(zipfile, tag)
  })

  names(all_files) <- all_zips

  all_files
}

#' @rdname find_files_from_zips
#'
#' @param zipfile Specific file to look in
#'
#' @importFrom utils unzip
find_files_from_zip <- function(zipfile, tag) {

  filenames <- unzip(zipfile, list = TRUE)$Name

  grep(paste0(".*", tag, ".*\\.(txt|tsv|csv)"), filenames, value = TRUE, ignore.case = TRUE)

}


#' Extract all files from a zip and write to a parquet file
#'
#' Several schemas are included in the package and accessed by passing
#' `dataset_name` and `table_name` to [get_schema()].
#' You can use `get_schema()` with no arguments to list available schemas.
#'
#' You can also construct a custom schema using [create_new_schema()]
#'
#' @param zip_directory Directory of zip files
#' @param write_directory Directory in which to write parquet files
#' @param dataset_tag Term that will identify relevant files (e.g. 'observation', 'consultation')
#' @param data_schema Table schema to use
#' @param table_name Optional, defaults to `dataset_tag`. Data for the table will be written in this sub-folder within `write_directory`
#' @param quietly Whether to print progress
#' @param zip_file_pattern Name pattern of zips to include (e.g. "Aurum.*\\.zip)
#' @param date_format Read dates from files in this format. Check dataset! Default "%d/%m/%Y"
#' @param allow_missing Fill missing schema columns with NA instead of erroring
#' @param ... Extra arguments passed to [append_to_parquet()] (e.g. date formatting)
#'
#' @export
#'
read_zipped_dataset_to_parquet <- function(zip_directory,
                                           write_directory,
                                           dataset_tag,
                                           data_schema = NULL,
                                           table_name = NULL,
                                           quietly = FALSE,
                                           date_format = "%d/%m/%Y",
                                           zip_file_pattern = ".*\\.zip",
                                           allow_missing = FALSE,
                                           ...) {
  if (is.null(table_name))
    table_name <- dataset_tag

  files_to_read <- find_files_from_zips(zip_directory, dataset_tag, zip_file_pattern = zip_file_pattern)


  files_to_read <- files_to_read[lapply(files_to_read, length) != 0]

  if (!is.null(data_schema) && !allow_missing) {
    missing_cols <- Map(\(tsv_files, zipfile) {
      lapply(tsv_files, \(filename) setdiff(data_schema$names, read_header(unz(zipfile, filename))))
    }, files_to_read, names(files_to_read))

    check_missing_columns(unique(unlist(missing_cols)), dataset_tag, allow_missing)
  }

  if (!dir.exists(write_directory))
    dir.create(write_directory)

  Map(\(tsv_files, zipfile) {
    files_n <- length(tsv_files)

    Map(\(filename, n) {
      if (!quietly)
        cat(paste0(
          n,
          "/",
          files_n,
          ": ",
          filename,
          " extracting and adding to parquet\n"
        ))

      read_file_from_zip(zipfile, filename, data_schema, allow_missing = allow_missing) |>
        append_to_parquet(write_directory, table_name, data_schema, date_format = date_format, ...)
    }, tsv_files, seq(files_n))


  }, files_to_read, names(files_to_read))

  invisible(files_to_read)
}

#' Read tsv files from directory into parquet files
#'
#' @param tsv_file_directory Directory with .txt tsv files
#' @param write_directory Directory in which to write parquet files
#' @param dataset_tag Term that will identify relevant files (e.g. 'observation', 'consultation').
#'   Matches any file containing the tag, in all sub-folders.
#' @param data_schema Table schema to use, e.g. from [get_schema()]. If `NULL`,
#'   all columns are read as text.
#' @param table_name Optional, defaults to `dataset_tag`. Data for the table will be written in this sub-folder within `write_directory`
#' @param quietly Whether to print progress
#' @param date_format Read dates from files in this format. Check dataset! Default "%d/%m/%Y"
#' @param allow_missing Fill missing schema columns with NA instead of erroring. Ignored if `data_schema` is `NULL`
#'
#' @returns The directory name where files were stored
#' @export
#'
read_tsv_dataset_to_parquet <- function(tsv_file_directory,
                                        write_directory,
                                        dataset_tag,
                                        data_schema = NULL,
                                        table_name = NULL,
                                        quietly = FALSE,
                                        date_format = "%d/%m/%Y",
                                        allow_missing = FALSE) {
  con <- DBI::dbConnect(duckdb::duckdb())


  if (is.null(table_name))
    table_name <- dataset_tag

  union_by_name <- !is.null(data_schema) && allow_missing

  read_from <- sprintf(
    "read_csv('%s/**/*%s*', all_varchar = true%s)",
    tsv_file_directory,
    dataset_tag,
    if (union_by_name) ", union_by_name = true" else ""
  )

  if (!is.null(data_schema)) {
    present_cols <- DBI::dbGetQuery(con, paste("DESCRIBE SELECT * FROM", read_from))$column_name

    check_missing_columns(setdiff(data_schema$names, present_cols), dataset_tag, allow_missing)

    cast_expression <- cast_expression_from_schema(data_schema, table_name, date_format = date_format,
                                                   present_cols = present_cols)
  } else {
    cast_expression <- sprintf("*, '%s'::VARCHAR as table", table_name)
  }

  if (!dir.exists(write_directory))
    dir.create(write_directory)

  sql <- sprintf(
    "
    COPY (
      SELECT %s
      FROM %s
    )
    TO '%s'
    (FORMAT 'parquet', COMPRESSION 'ZSTD', APPEND TRUE, PARTITION_BY ('table'))
  ",
    cast_expression,
    read_from,
    file.path(write_directory, table_name)
  )

  tryCatch(
    DBI::dbExecute(con, sql),
    error = function(e) {
      hint <- if (!is.null(data_schema) && !allow_missing && grepl("Binder Error|Schema mismatch", conditionMessage(e))) "\nIf columns are missing, set `allow_missing = TRUE`." else ""
      stop(conditionMessage(e), hint, call. = FALSE)
    }
  )

  write_directory

}

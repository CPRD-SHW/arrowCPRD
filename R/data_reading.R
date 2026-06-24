#' Read a single file from a zip file (into a `data.table`)
#'
#' @param zipfile The Zip file to read from
#' @param filename Filename within Zip file
#' @param schema A list with 'names' and 'read_in_types'
#' @param ... Additional arguments to `data.table::fread`
#'
#' @returns A `data.table`
#'
#' @import data.table
#' @export
#'
read_file_from_zip <- function(zipfile, filename, schema = NULL, ...) {
  if (is.null(schema)) {
    data.table::fread(cmd = sprintf("unzip -p %s %s", zipfile, filename), ...)
  } else {
    data.table::fread(
      cmd = sprintf("unzip -p %s %s", zipfile, filename),
      colClasses = schema$read_in_types, ...
    )
  }

}

#' Open a tsv file or multiple tsv files with a file_tag as an arrow dataset
#'
#' @param file_tag "observation", "practice" etc.
#' @param input_dir Directory with tsv files (or in sub-directories)
#' @param schema Optional - an `arrow::Scheme` object to set variable types
#'
#' @returns An arrow dataset
#'
#' @import arrow
#' @export
read_files_from_tsv <- function(file_tag, input_dir, schema = NULL) {

  schema <- schema$arrow_schema

  list.files(
    path      = input_dir,
    pattern   = paste0(file_tag, ".*\\.txt$"),
    full.names = TRUE,
    recursive  = TRUE,
    ignore.case = TRUE
  ) |>
    arrow::open_tsv_dataset(schema = schema, skip = 1)
}


#' Write an arrow dataset to a parquet file
#'
#' @param arrow_data An arrow dataset created from `read_files_from_tsv`
#' @param output_path Output path
#' @param partitioning Optional - variable to partition by
#'
#' @returns the output path
#' @importFrom dplyr compute
#' @import arrow
#' @export
#'
write_arrow_to_parquet <- function(arrow_data, output_path, partitioning = NULL) {

  arrow_data |>
    coerce_date_columns_arrow() |>
    dplyr::compute() |>
    arrow::write_dataset(output_path, partitioning = partitioning)

  output_path

}


#' Append data frame to parquet
#'
#' @param df A data frame
#' @param out_dir Out directory
#' @param table_name "Observation", "Patient" etc.
#' @param data_schema A schema with `names` and `read_in_types`
#' @param date_format Default "\%d/\%m/\%Y"
#'
#' @returns output directory
#'
#' @import duckdb DBI
#' @export
#'
append_to_parquet <- function(df, out_dir, table_name, data_schema, date_format = "%d/%m/%Y") {
  con <- DBI::dbConnect(duckdb::duckdb())

  duckdb::duckdb_register(con, "tmp_arrow", df)

  cast_expression <- cast_expression_from_schema(data_schema, table_name, date_format = date_format)

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
#' @param zip_directory Directory of zip files
#' @param write_directory Directory in which to write parquet files
#' @param dataset_tag Term that will identify relevant files (e.g. 'observation', 'consultation')
#' @param schema Table schema to use
#' @param table_name Optional, defaults to `dataset_tag`. Data for the table will be written in this sub-folder within `write_directory`
#' @param quietly Whether to print progress
#' @param zip_file_pattern Name pattern of zips to include (e.g. "Aurum.*\\.zip)
#' @param ... Extra arguments passed to `append_to_parquet` (e.g. date formatting)
#'
#' @export
#'
read_zipped_dataset_to_parquet <- function(zip_directory, write_directory, dataset_tag, schema, table_name = NULL, quietly = FALSE, zip_file_pattern = ".*\\.zip", ...) {

  if (is.null(table_name)) table_name <- dataset_tag
  if (!dir.exists(write_directory)) dir.create(write_directory)

  files_to_read <- find_files_from_zips(zip_directory, dataset_tag, zip_file_pattern = zip_file_pattern)


  Map(\(tsv_files, zipfile, n) {

    files_n <- length(tsv_files)

    lapply(tsv_files, \(filename) {

    if (!quietly) cat(paste0(n, "/", files_n, ": ", filename, " extracting and adding to parquet\n"))

    read_file_from_zip(zipfile, filename, schema) |>
      append_to_parquet(write_directory, table_name, schema, ...)
    })


  }, files_to_read, names(files_to_read), length(files_to_read))

}

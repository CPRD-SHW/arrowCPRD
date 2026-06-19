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
    data.table::fread(cmd = sprintf("unzip -p %s %s", zipfile, filename))
  } else {
    data.table::fread(
      cmd = sprintf("unzip -p %s %s", zipfile, filename),
      colClasses = schema$read_in_types
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
  list.files(
    path      = input_dir,
    pattern   = paste0(file_tag, ".*\\.txt$"),
    full.names = TRUE,
    recursive  = TRUE
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

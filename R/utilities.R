#' Create schema code for given names/types
#'
#' @param schema_in_names A vector of column names
#' @param schema_in_read_in_types A vector of column types
#'
#' @returns A function for generating an `arrow::Schema`
#' @import arrow
#'
get_arrow_schema <- function(schema_in_names, schema_in_read_in_types) {
  schema_obj <- mapply(\(names, read_in_types) {
    data_in <- data.frame(x <- do.call(read_in_types, args = list(1)))

    names(data_in) <- names

    data_in

  }, schema_in_names, schema_in_read_in_types, SIMPLIFY = FALSE) |>
    as.data.frame() |>
    arrow::as_arrow_table() |>
    arrow::schema()

  schema_obj$code

}

#' Coerce dates in data.table
#'
#' @import data.table
coerce_date_columns_dt <- function(data_in) {

  date_cols <- grep(".*date", names(data_in), value = TRUE)

  data_in[, (date_cols) := lapply(.SD, \(date_col)
                                  as.Date(date_col, tryFormats = c("%d/%m/%Y", "%Y/%m/%d"))
  ), .SDcols = date_cols]


}

#' Coerce dates in arrow dataset
#'
#' @importFrom dplyr mutate across matches
coerce_date_columns_arrow <- function(data_in) {


    data_in |>
      dplyr::mutate(dplyr::across(
        dplyr::matches("date", ignore.case = TRUE),
        ~ lubridate::parse_date_time(.x, orders = c("%d/%m/%Y", "%Y/%m/%d"))
      ))

}

#' Cast data-type schema to a duckdb schema
#'
#' @param data_schema A list with `names` and `read_in_types`
#' @param date_format (default "\%d/\%m/\%Y")
#'
#' @returns a string to be passed to duckdb as a cast expression
cast_expression_from_schema <- function(data_schema, table_name, date_format = "%d/%m/%Y") {

  variable_types <- data_schema$read_in_types
  names(variable_types) <- data_schema$names

  base_types <- c(
    character = "VARCHAR",
    integer = "BIGINT",
    numeric = "DOUBLE"
  )

  base_variables <- grep(".*date$", data_schema$names, value = TRUE, invert = TRUE)

  base_casts <- sprintf(
    "%s::%s AS %s",
    base_variables, base_types[variable_types[base_variables]], base_variables
  )

  time_variables <- grep(".*date$", data_schema$names, value = TRUE, invert = FALSE)



  date_casts <- sprintf(
    "CAST(try_strptime(%s, '%s') AS DATE) AS %s",
    time_variables, date_format, time_variables
  )


  paste(
    c(base_casts, date_casts, sprintf("'%s'::VARCHAR as table", table_name)),
    collapse = ",\n  "
  )

}


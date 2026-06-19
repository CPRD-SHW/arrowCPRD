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



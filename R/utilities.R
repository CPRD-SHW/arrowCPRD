#' Create schema code for given names/types
#'
#' @param schema_in_names A vector of column names
#' @param schema_in_read_in_types A vector of column types
#'
#' @returns A function for generating an `arrow::Schema`
#' @import arrow
#'
#' @keywords internal
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
#' @param data_in Dataset passed in
#' @param date_cols Character vector of column names to cast to date
#'
#' @import data.table
#' @keywords internal
coerce_date_columns_dt <- function(data_in, date_cols = NULL) {

  if (is.null(date_cols)) return(data_in)

  data_in[, (date_cols) := lapply(.SD, \(date_col)
                                  as.Date(date_col, tryFormats = c("%d/%m/%Y", "%Y/%m/%d"))
  ), .SDcols = date_cols]


}

#' Coerce dates in arrow dataset
#'
#' @param data_in Dataset passed in
#' @param date_cols Character vector of column names to cast to date
#'
#' @importFrom dplyr mutate across all_of
#' @importFrom lubridate parse_date_time
#' @keywords internal
coerce_date_columns_arrow <- function(data_in, date_cols = NULL) {

  if (length(date_cols) == 0) return(data_in)

  data_in |>
    dplyr::mutate(dplyr::across(
      dplyr::all_of(date_cols),
      ~ lubridate::parse_date_time(.x, orders = c("%d/%m/%Y", "%Y/%m/%d"))
    ))

}


#' Cast data-type schema to a duckdb schema
#'
#' @param data_schema A list with `names`, `read_in_types` and (optionally)
#'   `date_cols`
#' @param table_name Name of table to include in cast statement
#' @param date_format (default "%d/%m/%Y")
#'
#' @returns a string to be passed to duckdb as a cast expression
#' @keywords internal
cast_expression_from_schema <- function(data_schema, table_name, date_format = "%d/%m/%Y") {

  variable_types <- data_schema$read_in_types
  names(variable_types) <- data_schema$names

  base_types <- c(
    character = "VARCHAR",
    integer = "BIGINT",
    numeric = "DOUBLE",
    logical = "BOOLEAN"
  )

  time_variables <- data_schema$date_cols

  base_variables <- setdiff(data_schema$names, time_variables)

  base_casts <- sprintf(
    "%s::%s AS %s",
    base_variables, base_types[variable_types[base_variables]], base_variables
  )


  date_casts <- sprintf(
    "CAST(try_strptime(%s, '%s') AS DATE) AS %s",
    time_variables, date_format, time_variables
  )


  paste(
    c(base_casts, date_casts, sprintf("'%s'::VARCHAR as table", table_name)),
    collapse = ",\n  "
  )

}


#' Create a new schema for reading/writing CPRD to arrow
#'
#' @param col_names A vector of column names in your dataset
#' @param col_types A vector of column types ("character", "integer", "numeric")
#' @param date_cols A vector of column names to cast to date
#'
#' @returns A list with attributes for a schema to be passed to other objects
#' @export
#'
#' @examples
#' create_new_schema(
#'  col_names = c("name", "age", "birthdate"),
#'  col_types = c("character", "integer", "character"),
#'  date_cols = "birthdate"
#' )
#'
create_new_schema <- function(col_names, col_types, date_cols = NULL) {

  if (length(col_names) != length(col_types)) {
    stop(sprintf("Length of `col_names` (%d) should match length of `col_types` (%d)",
                 length(col_names), length(col_types)))
  }

  for (vartype in col_types) {
    if (vartype == "Date") {
      stop("Using \"Date\" type at this stage isn't recommended. Please use \"character\" for reading which can be later cast to date.")
    } else if (vartype %in% c("character", "integer", "numeric"))  {
      next
    } else {
      stop(sprintf("Variable type \"%s\" not recognised. Please use \"character\", \"integer\" or \"numeric\"", vartype))
    }
  }

  if (!is.null(date_cols) && !all(date_cols %in% col_names)) {
    missing_cols <- setdiff(date_cols, col_names)
    stop(sprintf("`date_cols` must be a subset of `col_names`. Not found: %s",
                 paste(missing_cols, collapse = ", ")))
  }

  list(
    names = col_names,
    read_in_types = col_types,
    date_cols = date_cols,
    arrow_schema = eval(get_arrow_schema(col_names, col_types)())
  )

}

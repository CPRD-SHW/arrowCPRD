#' DuckDB type -> arrow type
#' @keywords internal
.arrow_type_map <- list(
  character = arrow::utf8,
  integer = arrow::int64,
  numeric = arrow::float64,
  logical = arrow::bool
)

#' Build an `arrow::Schema` from column names and types
#'
#' @param col_names Character vector of column names
#' @param col_types Character vector of types
#'
#' @returns An `arrow::Schema`
#' @keywords internal
arrow_schema_from_types <- function(col_names, col_types) {
  unknown <- setdiff(col_types, names(.arrow_type_map))
  if (length(unknown) > 0) {
    stop(sprintf("Unknown column type(s): %s", paste(unique(unknown), collapse = ", ")),
         call. = FALSE)
  }

  fields <- Map(
    function(nm, ty) arrow::field(nm, .arrow_type_map[[ty]]()),
    col_names, col_types
  )

  do.call(arrow::schema, fields)
}

#' Expand a compact schema definition to a full schema
#'
#' @param spec A schema list with `col_types` (a named character vector) and
#'   optionally `date_cols`.
#'
#' @returns A list with `names`, `read_in_types`, `date_cols` and an 
#' evaluated `arrow_schema`.
#' @keywords internal
.expand_schema <- function(spec) {

  if (is.null(spec$col_types)) {
    return(spec) ## nocov
  }

  col_names <- names(spec$col_types)
  col_types <- unname(spec$col_types)

  out <- list(
    names = col_names,
    read_in_types = col_types,
    date_cols = spec$date_cols
  )

  if (!is.null(col_names) && !any(col_names == "")) {
    out$arrow_schema <- arrow_schema_from_types(col_names, col_types)
  }

  extra <- setdiff(names(spec), c("col_types", "date_cols", names(out)))
  out[extra] <- spec[extra]

  out
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
#' @param col_types A vector of column types ("character", "integer", "numeric",
#'   "logical")
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
    } else if (vartype %in% c("character", "integer", "numeric", "logical"))  {
      next
    } else {
      stop(sprintf("Variable type \"%s\" not recognised. Please use \"character\", \"integer\", \"numeric\" or \"logical\"", vartype))
    }
  }

  if (!is.null(date_cols) && !all(date_cols %in% col_names)) {
    missing_cols <- setdiff(date_cols, col_names)
    stop(sprintf("`date_cols` must be a subset of `col_names`. Not found: %s",
                 paste(missing_cols, collapse = ", ")))
  }

  .expand_schema(list(
    col_types = stats::setNames(col_types, col_names),
    date_cols = date_cols
  ))

}

#' Schemas for reading in Aurum data by types
#'
#' @param dataset_name Name of dataset - "aurum" or "gold"
#' @param table_name Name of table - "observation" etc.
#'
#' @returns A "schema" - a list of names of variables, r data types and arrow types
#'
#' @export
#' @examples
#' get_schema("aurum", "observation")
#' get_schema("aurum", "patient")
#'
get_schema <- function(dataset_name = NULL,
                       table_name = NULL) {
  if (is.null(dataset_name) || is.null(table_name)) {
    message(
      "Please use one of the following pairs of dataset/table names for a schema:\n - ",
      paste(gsub("_", " / ", x = names(.schemas())), collapse = "\n - ")
    )

    return(invisible())

  }

  key <- paste(dataset_name, table_name, sep = "_")

  schema <- .schemas()[[key]]

  if (is.null(schema)) {
    stop(sprintf("No schema found for '%s_%s'", dataset_name, table_name),
         call. = FALSE)
  }

  schema$arrow_schema <- eval(schema$arrow_schema)

  schema

}

#' All registered schemas
#'
#' @returns A named list of schemas as `<dataset>_<table>`
#' @noRd
.schemas <- function() {
  c(.schemas_aurum,
    .schemas_gold)
}

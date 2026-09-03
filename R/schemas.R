#' Schemas for reading in Aurum data by types
#'
#' @param dataset_name Name of dataset - "aurum", "gold", or "linked"
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
    keys <- names(.schemas())
    datasets <- sub("_.*$", "", keys)
    tables <- sub("^[^_]+_", "", keys)

    lines <- unlist(lapply(unique(datasets), function(ds) {
      in_ds <- datasets == ds
      c(
        sprintf("%s:", ds),
        sprintf('  get_schema("%s", "%s")', ds, tables[in_ds]),
        ""
      )
    }))

    message(
      "Please choose a dataset and table. Available schemas:\n\n",
      paste(lines, collapse = "\n")
    )

    return(invisible())

  }

  key <- paste(dataset_name, table_name, sep = "_")

  schema <- .schemas()[[key]]

  if (is.null(schema)) {
    stop(sprintf("No schema found for '%s_%s'", dataset_name, table_name),
         call. = FALSE)
  }

  .expand_schema(schema)

}

#' All registered schemas
#'
#' @returns A named list of schemas as `<dataset>_<table>`
#' @noRd
.schemas <- function() {
  c(.schemas_aurum,
    .schemas_gold,
    .schemas_linked_hes_apc,
    .schemas_linked_hes_op,
    .schemas_linked_hes_ae,
    .schemas_linked_hes_did,
    .schemas_linked_deaths,
    .schemas_linked_dispensing,
    .schemas_linked_smallarea,
    .schemas_linked_cancer)
}

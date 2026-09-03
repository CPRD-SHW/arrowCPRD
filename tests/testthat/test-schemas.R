test_that("get_schema returns error for only bad table/dataset name", {
  bad_dataset_name <- "goold"
  good_dataset_name <- "aurum"
  bad_table_name <- "patioont"
  good_table_name <- "observation"

  expect_error(
    get_schema(bad_dataset_name, good_table_name),
    regexp = sprintf(
      "No schema found for '%s_%s",
      bad_dataset_name,
      good_table_name
    )
  )

  expect_error(
    get_schema(good_dataset_name, bad_table_name),
    regexp = sprintf(
      "No schema found for '%s_%s",
      good_dataset_name,
      bad_table_name
    )
  )

  expect_contains(
    get_schema(good_dataset_name, good_table_name) |> names(),
    c("names", "read_in_types", "arrow_schema")
  )

})

test_that("schema gives suggestions", {

  expect_message(get_schema(), "Available schemas")
  expect_message(get_schema(), 'get_schema\\("linked", "hes_patient"\\)')

})

test_that("schema prints", {

  expect_no_error(print(get_schema("aurum", "patient")))

})

test_that("schema definitions are internally consistent", {
  for (key in names(.schemas())) {
    spec <- .schemas()[[key]]

    if (is.null(spec$col_types)) next

    col_names <- names(spec$col_types)

    expect_false(anyDuplicated(col_names) > 0,
                 info = sprintf("duplicate column names in '%s'", key))

    if (!is.null(spec$date_cols)) {
      expect_true(all(spec$date_cols %in% col_names),
                  info = sprintf("date_cols not a subset of columns in '%s'", key))
    }

    expect_no_error(.expand_schema(spec))
  }
})

test_that("schema types match up", {
  type_conversion <- c(
    character = "string",
    integer = "int64",
    logical = "bool",
    numeric = "double"
  )

  match_tables <- .schemas() |>
    purrr::map(.expand_schema) |>
    purrr::map(\(schema) {
      if (is.null(schema[["arrow_schema"]]))
        return(
          tibble::tibble(
            names = character(0),
            read_in_types = character(0),
            arrow = character(0),
          )
        )

      with(schema, {
        codes <- arrow_schema
        tibble::tibble(names,
                       read_in_types,
                       arrow = codes$fields |> purrr::map_chr(~ .x$ToString()))
      })

    }) |>
    purrr::map(\(types_table) {
      types_table |>
        dplyr::mutate(type_switch = type_conversion[read_in_types]) |>
        dplyr::filter(!stringr::str_detect(arrow, names) |
                        !stringr::str_detect(arrow, type_switch))

    })


  expect_all_equal(vapply(match_tables, nrow, integer(1)), 0L)

})

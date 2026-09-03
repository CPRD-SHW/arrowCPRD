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

  expect_message(get_schema(), "Please use one of the following")

})

test_that("schema prints", {

  expect_no_error(print(get_schema("aurum", "patient")))

})

test_that("schema types match up", {
  type_conversion <- c(
    character = "string",
    integer = "int64",
    logical = "bool",
    numeric = "double"
  )

  match_tables <- .schemas() |>
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
        codes <- eval(arrow_schema)
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

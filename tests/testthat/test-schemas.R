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


test_that("schema prints", {

  expect_no_error(print(get_schema("aurum", "patient")))

})

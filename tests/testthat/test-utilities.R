test_that("reading schema works", {

  schema_code <- get_arrow_schema(c("a", "b", "c"), c("integer", "character", "numeric"))

  expected_schema <- arrow::schema(a = arrow::int32(), b = arrow::utf8(), c = arrow::float64())

  out_schema <- eval(schema_code(namespace = TRUE))

  expect_equal(expected = expected_schema$names, object = out_schema$names)
  expect_equal(expected = expected_schema$ToString(), object = out_schema$ToString())

})

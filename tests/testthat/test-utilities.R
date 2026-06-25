test_that("reading schema works", {

  schema_code <- get_arrow_schema(c("a", "b", "c"), c("integer", "character", "numeric"))

  expected_schema <- arrow::schema(a = arrow::int32(), b = arrow::utf8(), c = arrow::float64())

  out_schema <- eval(schema_code(namespace = TRUE))

  expect_equal(expected = expected_schema$names, object = out_schema$names)
  expect_equal(expected = expected_schema$ToString(), object = out_schema$ToString())

})


test_that("coercing dates in a data.table works", {

  dt_in <- data.table::data.table(adate = "2026/01/01", bdate = "02/03/2028")

  coerce_date_columns_dt(dt_in)

  expect_equal(dt_in$adate, as.Date("2026/01/01", format = "%Y/%m/%d"))
  expect_equal(dt_in$bdate, as.Date("2028/03/02", format = "%Y/%m/%d"))

})

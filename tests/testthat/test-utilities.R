test_that("reading schema works", {

  out_schema <- arrow_schema_from_types(c("a", "b", "c"), c("integer", "character", "numeric"))

  expected_schema <- arrow::schema(a = arrow::int64(), b = arrow::utf8(), c = arrow::float64())

  expect_equal(expected = expected_schema$names, object = out_schema$names)
  expect_equal(expected = expected_schema$ToString(), object = out_schema$ToString())

})


test_that("coercing dates in a data.table works", {

  dt_in <- data.table::data.table(adate = "2026/01/01", bdate = "02/03/2028")

  coerce_date_columns_dt(dt_in, date_cols = c("adate", "bdate"))

  expect_equal(dt_in$adate, as.Date("2026/01/01", format = "%Y/%m/%d"))
  expect_equal(dt_in$bdate, as.Date("2028/03/02", format = "%Y/%m/%d"))

})

test_that("coerce_date_columns_dt() doesn't touch columns when date_cols is NULL", {

  dt_no_dates <- data.table::data.table(data.frame(dont_touch_me_date = c("2026/05/01", "2022/04/31")))

  coerce_date_columns_dt(dt_no_dates)

  expect_equal(dt_no_dates$dont_touch_me_date, c("2026/05/01", "2022/04/31"))

})

test_that("new schema catches wrong-length arguments", {

  expect_error(

    create_new_schema(
      col_names = c("name", "age", "birthdate"),
      col_types = c("character", "integer", "character", "integer")
    ),
    "Length of `col_names` \\(3\\) should match length of `col_types` \\(4\\)"
  )

})

test_that("new schema catches wrong variable types", {

  expect_error(

    create_new_schema(
      col_names = c("name", "age", "birthdate"),
      col_types = c("character", "integer", "fakevar")
    ),
    "Variable type \"fakevar\" not recognised. Please use \"character\", \"integer\" or \"numeric\""
  )

})

test_that("new schema catches date types", {

  expect_error(

    create_new_schema(
      col_names = c("name", "age", "birthdate"),
      col_types = c("character", "integer", "Date")
    ),
    "Using \"Date\" type at this stage isn't recommended. Please use \"character\" for reading which can be later cast to date."
  )

})


test_that("new schema can be created", {
  new_schema <- create_new_schema(
    col_names = c("name", "age", "birthdate"),
    col_types = c("character", "integer", "character"),
    date_cols = "birthdate"
  )

  expected <- list(
    names = c("name", "age", "birthdate"),
    read_in_types = c("character", "integer", "character"),
    date_cols = "birthdate",
    arrow_schema = arrow::schema(
      name = arrow::utf8(),
      age = arrow::int32(),
      birthdate = arrow::utf8()
    )
  )

  expect_equal(names(new_schema), names(expected))
  expect_equal(new_schema$names, expected$names)
  expect_equal(new_schema$read_in_types, expected$read_in_types)
  expect_equal(new_schema$date_cols, expected$date_cols)
  expect_equal(new_schema$arrow_schema$num_fields, expected$arrow_schema$num_fields)

})

test_that("new schema rejects date_cols not in col_names", {

  expect_error(
    create_new_schema(
      col_names = c("name", "age", "birthdate"),
      col_types = c("character", "integer", "character"),
      date_cols = c("birthdate", "notacol")
    ),
    "`date_cols` must be a subset of `col_names`. Not found: notacol"
  )

})

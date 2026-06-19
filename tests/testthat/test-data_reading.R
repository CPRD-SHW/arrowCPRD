test_that("reading and single file from zip works", {
  data_in <- read_file_from_zip(
    test_path("data", "testdata.zip"),
    "aurum_allpatid_set1_extract_observation_001.txt",
    aurum_observation_schemas,
    nrow = 5
  )

  expect_s3_class(data_in, "data.table")

})

test_that("reading tsv files work", {

  data_in <- read_files_from_tsv("observation", test_path("data", "testdata"), aurum_observation_schemas$arrow_schema)


  expect_r6_class(data_in, "Dataset")


})

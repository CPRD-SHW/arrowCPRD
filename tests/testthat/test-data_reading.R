test_that("reading a single file from observations zip works", {
  data_in <- read_file_from_zip(
    test_path("data", "testdata.zip"),
    "aurum_allpatid_set1_extract_observation_001.txt",
    get_schema("aurum", "observation"),
    nrow = 5
  )

  expect_s3_class(data_in, "data.table")

})

test_that("reading a single file from patient zip works", {
  data_in <- read_file_from_zip(
    test_path("data", "testdata.zip"),
    "aurum_allpatid_set1_extract_patient_001.txt",
    get_schema("aurum", "patient"),
    nrow = 5
  )

  expect_s3_class(data_in, "data.table")

})


test_that("reading tsv files work", {
  data_in <- read_files_from_tsv("observation",
                                 test_path("data", "testdata"),
                                 get_schema("aurum", "observation"))


  expect_r6_class(data_in, "Dataset")


})

test_that("reading tsv files non-case sensitive", {

  data_in <- read_files_from_tsv("Observation", test_path("data", "testdata"), get_schema("aurum", "observation"))


  expect_r6_class(data_in, "Dataset")


})

test_that("writing to parquet works", {

  temp_pq <- withr::local_tempdir()

  data_in <- read_files_from_tsv("observation", test_path("data", "testdata"), get_schema("aurum", "observation"))

  data_in |>
    write_arrow_to_parquet(temp_pq)

  pq_in <- open_dataset(temp_pq)


  expect_equal(nrow(pq_in), 300)
  expect_no_error(pq_in)

  on.exit(unlink(temp_pq))
})

test_that("reading sequential zips to parquet works", {

  temp_pq <- withr::local_tempdir()

  read_file_from_zip(
    test_path("data", "testdata.zip"),
    "aurum_allpatid_set1_extract_observation_001.txt",
    get_schema("aurum", "observation"),
    nrows = 100
  ) |> append_to_parquet(temp_pq, "observations", get_schema("aurum", "observation"))

  read_file_from_zip(
    test_path("data", "testdata.zip"),
    "aurum_allpatid_set1_extract_observation_002.txt",
    get_schema("aurum", "observation"),
    nrows = 100
  ) |> append_to_parquet(temp_pq, "observations", get_schema("aurum", "observation"))


  pq_in <- open_dataset(file.path(temp_pq, "observations")) |>
    tibble::as_tibble()

  expect_no_error(pq_in)

  on.exit(unlink(temp_pq))

})

test_that("reading all zips in a folder to parquet works", {

  temp_pq <- withr::local_tempdir()

  read_zipped_dataset_to_parquet(
    test_path("data"),
    write_directory = temp_pq,
    dataset_tag = "patient",
    schema = get_schema("aurum", "patient"),
    table_name = "fake_name"
  )

  pq_in <- open_dataset(file.path(temp_pq, "fake_name")) |>
    tibble::as_tibble()

  expect_no_error(pq_in)
  expect_s3_class(pq_in$regstartdate, "Date")

  on.exit(unlink(temp_pq))
})

test_that("finding files in a zip works", {

  temp_pq <- withr::local_tempdir()

  writeLines("one", file.path(temp_pq, "testfile1.txt"))
  writeLines("two", file.path(temp_pq, "testfile2.txt"))

  zip(file.path(temp_pq, "zipped.zip"), files = file.path(temp_pq))

  zip_path <- file.path(temp_pq, "zipped.zip")

  files_in <- find_files_from_zip(zip_path, "testfile")

  expected <- c(file.path(temp_pq, "testfile1.txt"), file.path(temp_pq, "testfile2.txt"))

  expect_equal(length(files_in), length(expected))

  on.exit(unlink(temp_pq))

})

test_that("finding files in a zip is non-case sensitive", {

  temp_pq <- withr::local_tempdir()

  writeLines("one", file.path(temp_pq, "testfile1.txt"))
  writeLines("two", file.path(temp_pq, "testfile2.txt"))

  zip(file.path(temp_pq, "zipped.zip"), files = file.path(temp_pq))

  zip_path <- file.path(temp_pq, "zipped.zip")

  files_in <- find_files_from_zip(zip_path, "Testfile")

  expected <- c(file.path(temp_pq, "testfile1.txt"), file.path(temp_pq, "testfile2.txt"))

  expect_equal(length(files_in), length(expected))

  on.exit(unlink(temp_pq))

})

test_that("files across multiple zips works", {

  temp_pq <- withr::local_tempdir()

  writeLines("one", file.path(temp_pq, "testfile1.txt"))
  writeLines("two", file.path(temp_pq, "testfile2.txt"))

  zip(file.path(temp_pq, "zipped1.zip"), files = file.path(temp_pq, "testfile1.txt"))
  zip(file.path(temp_pq, "zipped2.zip"), files = file.path(temp_pq, "testfile2.txt"))

  zip_paths <- file.path(temp_pq)

  files_in <- find_files_from_zips(zip_paths, "testfile")

  expected <- list(file.path(temp_pq, "testfile1.txt"), file.path(temp_pq, "testfile2.txt"))
  names(expected) <- c(file.path(temp_pq, "testfile1.txt"), file.path(temp_pq, "testfile2.txt"))

  expect_equal(length(files_in), length(expected))

  on.exit(unlink(temp_pq))

})

test_that("files across multiple zips allows wildcards in file pattern name", {

  temp_pq <- withr::local_tempdir()

  writeLines("one", file.path(temp_pq, "testfile1.txt"))
  writeLines("two", file.path(temp_pq, "testfile2.txt"))

  dir.create(file.path(temp_pq, "data1"))

  zip(file.path(temp_pq, "data1_zipped1.zip"), files = file.path(temp_pq, "testfile1.txt"))
  zip(file.path(temp_pq, "data1_zipped2.zip"), files = file.path(temp_pq, "testfile2.txt"))

  zip_paths <- file.path(temp_pq)

  files_in <- find_files_from_zips(zip_paths, "testfile", zip_file_pattern = "data._.*\\.zip")

  expected <- list(file.path(temp_pq, "testfile1.txt"), file.path(temp_pq, "testfile2.txt"))
  names(expected) <- c(file.path(temp_pq, "testfile1.txt"), file.path(temp_pq, "testfile2.txt"))

  expect_equal(length(files_in), length(expected))

  on.exit(unlink(temp_pq))

})

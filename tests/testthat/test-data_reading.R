# Reading in files --------------------------------------------------------

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


test_that("reading a file from zip allows spaces", {
  temp_pq <- withr::local_tempdir()


  dir.create(file.path(temp_pq, "folder with spaces"))

  writeLines("one", file.path(temp_pq, "testfile 1.txt"))
  writeLines("one",
             file.path(temp_pq, "folder with spaces", "testfile2.txt"))

  zip(file.path(temp_pq, "zipped.zip"), files = file.path(temp_pq))

  zip_path <- file.path(temp_pq, "zipped.zip")

  file1 <- find_files_from_zip(zip_path, tag = "testfile 1")
  file2 <- find_files_from_zip(zip_path, tag = "testfile2")

  expect_no_error(in_file1 <- read_file_from_zip(zip_path, file1))

  expect_no_error(in_file2 <- read_file_from_zip(zip_path, file2))

  on.exit(unlink(temp_pq))

})

test_that("writing to parquet from zip allows spaces", {
  temp_pq <- withr::local_tempdir()


  dir.create(file.path(temp_pq, "folder with spaces"))

  writeLines("one\n3", file.path(temp_pq, "testfile 1.txt"))
  writeLines("one\n4",
             file.path(temp_pq, "folder with spaces", "testfile2.txt"))

  zip(file.path(temp_pq, "zipped.zip"), files = file.path(temp_pq))

  zip_path <- file.path(temp_pq, "zipped.zip")

  temp_schema <- list(names = "one", read_in_types = "integer")
  temp_schema$arrow_schema <- arrow::schema(one = arrow::int64())

  expect_no_error(
    read_zipped_dataset_to_parquet(
      temp_pq,
      file.path(temp_pq, "parquet out"),
      "testfile",
      schema = temp_schema
    )
  )

  expected <- tibble::tribble(~ one, ~ table, 3, "testfile", 4, "testfile")

  actual <- open_dataset(file.path(temp_pq, "parquet out")) |>
    tibble::as_tibble() |>
    dplyr::arrange(one)

  expect_equal(expected, actual)

  on.exit(unlink(temp_pq))

})


test_that("reading tsv files work", {
  data_in <- read_files_from_tsv("observation",
                                 test_path("data", "testdata"),
                                 get_schema("aurum", "observation"))


  expect_r6_class(data_in, "Dataset")


})

test_that("reading tsv files non-case sensitive", {
  data_in <- read_files_from_tsv("Observation",
                                 test_path("data", "testdata"),
                                 get_schema("aurum", "observation"))


  expect_r6_class(data_in, "Dataset")


})

test_that("reading zip with null schema works", {
  data_in <- read_file_from_zip(
    test_path("data", "testdata.zip"),
    "aurum_allpatid_set1_extract_observation_001.txt",
    nrow = 5
  )

  expect_s3_class(data_in, "data.table")


})

test_that("reading tsv with null schema works", {
  data_in <- read_files_from_tsv("observation", test_path("data", "testdata"))


  expect_r6_class(data_in, "Dataset")

})


# Writing outputs ---------------------------------------------------------

test_that("writing to parquet works", {
  temp_pq <- withr::local_tempdir()

  data_in <- read_files_from_tsv("observation",
                                 test_path("data", "testdata"),
                                 get_schema("aurum", "observation"))

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

test_that("reading all zips takes a null schema", {
  temp_pq <- withr::local_tempdir()

  read_zipped_dataset_to_parquet(
    test_path("data"),
    write_directory = temp_pq,
    dataset_tag = "observation",
    table_name = "fake_name"
  )

  pq_in <- open_dataset(file.path(temp_pq, "fake_name")) |>
    tibble::as_tibble()

  expect_no_error(pq_in)
  expect_s3_class(pq_in$obsdate, "Date")

  on.exit(unlink(temp_pq))
})


# Finding files -----------------------------------------------------------



test_that("finding files in a zip works", {
  temp_pq <- withr::local_tempdir()

  writeLines("one", file.path(temp_pq, "testfile1.txt"))
  writeLines("two", file.path(temp_pq, "testfile2.txt"))

  zip(file.path(temp_pq, "zipped.zip"), files = file.path(temp_pq))

  zip_path <- file.path(temp_pq, "zipped.zip")

  files_in <- find_files_from_zip(zip_path, "testfile")

  expected <- c(file.path(temp_pq, "testfile1.txt"),
                file.path(temp_pq, "testfile2.txt"))

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

  expected <- c(file.path(temp_pq, "testfile1.txt"),
                file.path(temp_pq, "testfile2.txt"))

  expect_equal(length(files_in), length(expected))

  on.exit(unlink(temp_pq))

})

test_that("files across multiple zips works", {
  temp_pq <- withr::local_tempdir()

  writeLines("one", file.path(temp_pq, "testfile1.txt"))
  writeLines("two", file.path(temp_pq, "testfile2.txt"))

  zip(file.path(temp_pq, "zipped1.zip"),
      files = file.path(temp_pq, "testfile1.txt"))
  zip(file.path(temp_pq, "zipped2.zip"),
      files = file.path(temp_pq, "testfile2.txt"))

  zip_paths <- file.path(temp_pq)

  files_in <- find_files_from_zips(zip_paths, "testfile")

  expected <- list(file.path(temp_pq, "testfile1.txt"),
                   file.path(temp_pq, "testfile2.txt"))
  names(expected) <- c(file.path(temp_pq, "testfile1.txt"),
                       file.path(temp_pq, "testfile2.txt"))

  expect_equal(length(files_in), length(expected))

  on.exit(unlink(temp_pq))

})

test_that("files across multiple zips allows wildcards in file pattern name",
          {
            temp_pq <- withr::local_tempdir()

            writeLines("one", file.path(temp_pq, "testfile1.txt"))
            writeLines("two", file.path(temp_pq, "testfile2.txt"))

            dir.create(file.path(temp_pq, "data1"))

            zip(file.path(temp_pq, "data1_zipped1.zip"),
                files = file.path(temp_pq, "testfile1.txt"))
            zip(file.path(temp_pq, "data1_zipped2.zip"),
                files = file.path(temp_pq, "testfile2.txt"))

            zip_paths <- file.path(temp_pq)

            files_in <- find_files_from_zips(zip_paths, "testfile", zip_file_pattern = "data._.*\\.zip")

            expected <- list(file.path(temp_pq, "testfile1.txt"),
                             file.path(temp_pq, "testfile2.txt"))
            names(expected) <- c(file.path(temp_pq, "testfile1.txt"),
                                 file.path(temp_pq, "testfile2.txt"))

            expect_equal(length(files_in), length(expected))

            on.exit(unlink(temp_pq))

          })


# date parsing ------------------------------------------------------------

test_that("dates in alternative formats work in reading tsvs", {
  temp_pq <- withr::local_tempdir()

  dates1 <- data.frame(id = 1:2,
                       a_date = c("01/02/2025", "06/04/2020"))
  dates2 <- data.frame(id = 1:2,
                       a_date = c("2025/02/01", "2020/04/06"))

  write.table(
    dates1,
    file.path(temp_pq, "testfile1.txt"),
    sep = "\t",
    row.names = FALSE
  )
  write.table(
    dates2,
    file.path(temp_pq, "testfile2.txt"),
    sep = "\t",
    row.names = FALSE
  )



  read_files_from_tsv(1, temp_pq) |>
    write_arrow_to_parquet(file.path(temp_pq, "test1"), date_cols = "a_date")

  read_files_from_tsv(2, temp_pq) |>
    write_arrow_to_parquet(file.path(temp_pq, "test2"), date_cols = "a_date")


  expect_equal(
    open_dataset(file.path(temp_pq, "test1")) |> dplyr::collect(),
    open_dataset(file.path(temp_pq, "test2")) |> dplyr::collect()
  )

  on.exit(unlink(temp_pq))

})

test_that("dates in alternative formats work in reading zips", {
  temp_pq <- withr::local_tempdir()

  dates1 <- data.frame(id = 1:2,
                       a_date = c("01/02/2025", "06/04/2020"))
  dates2 <- data.frame(id = 1:2,
                       a_date = c("2025/02/01", "2020/04/06"))

  write.table(
    dates1,
    file.path(temp_pq, "testfile1.txt"),
    sep = "\t",
    row.names = FALSE
  )
  write.table(
    dates2,
    file.path(temp_pq, "testfile2.txt"),
    sep = "\t",
    row.names = FALSE
  )

  zip(file.path(temp_pq, "zipped.zip"), files = file.path(temp_pq))

  zip_path <- file.path(temp_pq, "zipped.zip")

  file1 <- find_files_from_zip(zip_path, tag = "testfile1")
  file2 <- find_files_from_zip(zip_path, tag = "testfile2")

  date_schema <- create_new_schema(
    col_names = c("id", "a_date"),
    col_types = c("integer", "character"),
    date_cols = "a_date"
  )

  read_file_from_zip(zip_path, file1) |>
    append_to_parquet(file.path(temp_pq), "test1", date_schema)

  read_file_from_zip(zip_path, file2) |>
    append_to_parquet(file.path(temp_pq), "test2", date_schema, date_format = "%Y/%m/%d")

  expect_equal(
    open_dataset(file.path(temp_pq, "test1")) |> dplyr::select(id, a_date) |> dplyr::collect(),
    open_dataset(file.path(temp_pq, "test2")) |> dplyr::select(id, a_date) |> dplyr::collect()
  )

  on.exit(unlink(temp_pq))

})


test_that("dataset can take alternative date formats", {
  temp_pq <- withr::local_tempdir()

  dates1 <- data.frame(
    id = 1:2,
    a_date = c("2022oolalala02oolalala05", "2019oolalala05oolalala05")
  )
  dates2 <- data.frame(
    id = 1:2,
    a_date = c("2025oolalala02oolalala01", "2020oolalala04oolalala06")
  )

  write.table(
    dates1,
    file.path(temp_pq, "testfile1.txt"),
    sep = "\t",
    row.names = FALSE
  )
  write.table(
    dates2,
    file.path(temp_pq, "testfile2.txt"),
    sep = "\t",
    row.names = FALSE
  )

  zip(file.path(temp_pq, "zipped.zip"), files = file.path(temp_pq))

  zip_path <- file.path(temp_pq, "zipped.zip")

  date_schema <- create_new_schema(
    col_names = c("id", "a_date"),
    col_types = c("integer", "character"),
    date_cols = "a_date"
  )

  read_zipped_dataset_to_parquet(
    temp_pq,
    file.path(temp_pq, "test_dataset"),
    dataset_tag = "testfile",
    schema = date_schema,
    date_format = "%Yoolalala%moolalala%d"
  )

  expected_dates <- as.Date(c("2019/05/05", "2020/04/06", "2022/02/05", "2025/02/01"))

  expect_equal(
    open_dataset(file.path(temp_pq, "test_dataset")) |> dplyr::arrange(a_date) |> dplyr::pull(a_date, as_vector = TRUE),
    expected_dates
  )

  on.exit(unlink(temp_pq))


})

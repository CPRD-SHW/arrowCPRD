
# arrowCPRD

<!-- badges: start -->
[![R-CMD-check](https://github.com/CPRD-SHW/arrowCPRD/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CPRD-SHW/arrowCPRD/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/CPRD-SHW/arrowCPRD/graph/badge.svg)](https://app.codecov.io/gh/CPRD-SHW/arrowCPRD)
<!-- badges: end -->

The goal of arrowCPRD is to allow a user of CPRD data to read these large tsv files into compressed, columnar, fast-reading [parquet](https://parquet.apache.org/docs/) files.
You can read your data in after unzipping it, or read it straight from the zipped files! To get started, try some things below.

## Installation

You can install the development version of arrowCPRD from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("CPRD-SHW/arrowCPRD")
```

## Creating parquet directly from zip files

You can use the function `read_zipped_dataset_to_parquet`

``` r
library(arrowCPRD)

read_zipped_dataset_to_parquet(
  zip_directory = "path/to/zipped/data",
  write_directory = "parquet_data",
  dataset_tag = "patient",
  data_schema = get_schema("aurum", "patient"),
  table_name = "patient"
)

# Loading dataset in a fresh session

library(arrow)

pq_patient <- open_dataset("parquet_data/patient") |>
  tibble::as_tibble()
```

You can do this for each of the tables ('patient', 'observation', 'practice') in your dataset.

`pq_patient` then functions like a normal data frame (running `collect` to bring into R session after computations):


``` r
library(tidyverse)

pq_patient |> 
  summarise(mean_val = mean(value), .by = "pracid") |>
  collect()
```

## Creating parquet files from unzipped datasets

If you've unzipped your CPRD data, you can use `read_tsv_dataset_to_parquet` on the whole folder also. This works the same way for primary care and linked data.

``` r
# Aurum primary care data
read_tsv_dataset_to_parquet(
  tsv_file_directory = "path/to/data",
  write_directory = "parquet_data",
  dataset_tag = "observation",
  data_schema = get_schema("aurum", "observation"),
  table_name = "observation"
)

# Linked HES APC data
read_tsv_dataset_to_parquet(
  tsv_file_directory = "path/to/linked/data",
  write_directory = "parquet_data",
  dataset_tag = "hes_patient",
  data_schema = get_schema("linked", "hes_patient"),
  table_name = "hes_patient"
)

# Loading datasets in a fresh session

library(arrow)

pq_observation <- open_dataset("parquet_data/observation")
pq_hes_patient <- open_dataset("parquet_data/hes_patient")
```

## Finding a schema

Schemas are chosen by dataset (`"aurum"`, `"gold"` or `"linked"`) and table.
Linked data always uses `"linked"`, whatever database it is linked to. To list
every available schema:

``` r
get_schema()
```

# More to come!

Check back here for more useful parts perhaps!


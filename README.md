
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
  [folder containing zipped cprd aurum files],
  write_directory = "parquet_data",
  dataset_tag = "patient",
  schema = get_schema("aurum", "patient"),
  table_name = "patient"
)

# Loading dataset in a fresh session

library(arrow)

pq_in <- open_dataset("parquet_data") |>
  tibble::as_tibble()
```

You can do this for each of the tables ('patient', 'observation', 'practice') in your dataset.

`pq_in` then functions like a normal data frame (running `collect` to bring into R session after computations):


``` r
library(tidyverse)

pq_in |> 
  summarise(mean_val = mean(value), .by = "pracid") |>
  collect()
```

## Creating parquet files from unzipped datasets

If you've unzipped your CPRD data, you can use `read_tsv_dataset_to_parquet` on the whole folder also.

``` r
read_tsv_dataset_to_parquet(
  tsv_file_directory = "path/to/data",
  write_directory ="parquet_files/observation",
  dataset_tag = "observation",
  data_schema = get_schema("aurum", "observation")
)

# Loading dataset in a fresh session

library(arrow)

pq_in <- open_dataset("parquet_files/observation")
  
```

# More to come!

Check back here for more useful parts perhaps!


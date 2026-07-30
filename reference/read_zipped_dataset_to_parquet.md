# Extract all files from a zip and write to a parquet file

Extract all files from a zip and write to a parquet file

## Usage

``` r
read_zipped_dataset_to_parquet(
  zip_directory,
  write_directory,
  dataset_tag,
  data_schema = NULL,
  table_name = NULL,
  quietly = FALSE,
  date_format = "%d/%m/%Y",
  zip_file_pattern = ".*\\.zip",
  ...
)
```

## Arguments

- zip_directory:

  Directory of zip files

- write_directory:

  Directory in which to write parquet files

- dataset_tag:

  Term that will identify relevant files (e.g. 'observation',
  'consultation')

- data_schema:

  Table schema to use

- table_name:

  Optional, defaults to `dataset_tag`. Data for the table will be
  written in this sub-folder within `write_directory`

- quietly:

  Whether to print progress

- date_format:

  Read dates from files in this format. Check dataset! Default
  "%d/%m/%Y"

- zip_file_pattern:

  Name pattern of zips to include (e.g. "Aurum.\*\\zip)

- ...:

  Extra arguments passed to
  [`append_to_parquet()`](https://cprd-shw.github.io/arrowCPRD/reference/append_to_parquet.md)
  (e.g. date formatting)

  Several schemas are included in the package and accessed by passing
  `dataset_name` and `table_name` to
  [`get_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/get_schema.md).
  You can use
  [`get_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/get_schema.md)
  with no arguments to list available schemas.

  You can also construct a custom schema using
  [`create_new_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/create_new_schema.md)

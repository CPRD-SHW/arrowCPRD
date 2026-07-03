# Extract all files from a zip and write to a parquet file

Extract all files from a zip and write to a parquet file

## Usage

``` r
read_zipped_dataset_to_parquet(
  zip_directory,
  write_directory,
  dataset_tag,
  schema = NULL,
  table_name = NULL,
  quietly = FALSE,
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

- schema:

  Table schema to use

- table_name:

  Optional, defaults to \`dataset_tag\`. Data for the table will be
  written in this sub-folder within \`write_directory\`

- quietly:

  Whether to print progress

- zip_file_pattern:

  Name pattern of zips to include (e.g. "Aurum.\*\\zip)

- ...:

  Extra arguments passed to \`append_to_parquet\` (e.g. date formatting)

  Several schemas are included in the package and accessed by passing
  \`dataset_name\` and \`table_name\` to \[get_schema()\]. You can use
  \`get_schema()\` with no arguments to list available schemas.

  You can also construct a custom schema using \[create_schema()\]

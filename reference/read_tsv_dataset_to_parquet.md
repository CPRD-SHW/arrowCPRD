# Read tsv files from directory into parquet files

Read tsv files from directory into parquet files

## Usage

``` r
read_tsv_dataset_to_parquet(
  tsv_file_directory,
  write_directory,
  dataset_tag,
  data_schema,
  table_name = NULL,
  quietly = FALSE,
  date_format = "%d/%m/%Y"
)
```

## Arguments

- tsv_file_directory:

  Directory with .txt tsv files

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

## Value

The directory name where files were stored

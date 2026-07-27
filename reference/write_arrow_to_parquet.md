# Write an arrow dataset to a parquet file

Write an arrow dataset to a parquet file

## Usage

``` r
write_arrow_to_parquet(
  arrow_data,
  output_path,
  partitioning = NULL,
  date_cols = NULL
)
```

## Arguments

- arrow_data:

  An arrow dataset created from `read_files_from_tsv`

- output_path:

  Output path

- partitioning:

  Optional - variable to partition by

- date_cols:

  Character vector of column names to cast to date

## Value

the output path

# Append data frame to parquet

Append data frame to parquet

## Usage

``` r
append_to_parquet(
  df,
  out_dir,
  table_name,
  data_schema,
  date_format = "%d/%m/%Y"
)
```

## Arguments

- df:

  A data frame

- out_dir:

  Out directory

- table_name:

  "Observation", "Patient" etc.

- data_schema:

  A schema with \`names\` and \`read_in_types\`

- date_format:

  Default "%d/%m/%Y"

## Value

output directory

# Append data frame to parquet

Append data frame to parquet

## Usage

``` r
append_to_parquet(
  df,
  out_dir,
  table_name,
  data_schema = NULL,
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

  A schema with `names` and `read_in_types`

- date_format:

  Default "%d/%m/%Y"

  Several schemas are included in the package and accessed by passing
  `dataset_name` and `table_name` to
  [`get_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/get_schema.md).
  You can use
  [`get_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/get_schema.md)
  with no arguments to list available schemas.

  You can also construct a custom schema using
  [`create_new_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/create_new_schema.md)

## Value

output directory

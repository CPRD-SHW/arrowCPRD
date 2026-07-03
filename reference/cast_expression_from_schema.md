# Cast data-type schema to a duckdb schema

Cast data-type schema to a duckdb schema

## Usage

``` r
cast_expression_from_schema(
  data_schema,
  table_name,
  date_format = "%d/%m/%Y"
)
```

## Arguments

- data_schema:

  A list with `names` and `read_in_types`

- table_name:

  Name of table to include in cast statement

- date_format:

  (default "%d/%m/%Y")

## Value

a string to be passed to duckdb as a cast expression

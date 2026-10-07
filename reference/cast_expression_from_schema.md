# Cast data-type schema to a duckdb schema

Cast data-type schema to a duckdb schema

## Usage

``` r
cast_expression_from_schema(
  data_schema,
  table_name,
  date_format = "%d/%m/%Y",
  present_cols = data_schema$names
)
```

## Arguments

- data_schema:

  A list with `names`, `read_in_types` and (optionally) `date_cols`

- table_name:

  Name of table to include in cast statement

- date_format:

  (default "%d/%m/%Y")

- present_cols:

  Columns present in the data; others are filled with NA

## Value

a string to be passed to duckdb as a cast expression

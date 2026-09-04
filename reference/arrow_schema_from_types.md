# Build an `arrow::Schema` from column names and types

Build an
[`arrow::Schema`](https://arrow.apache.org/docs/r/reference/Schema-class.html)
from column names and types

## Usage

``` r
arrow_schema_from_types(col_names, col_types)
```

## Arguments

- col_names:

  Character vector of column names

- col_types:

  Character vector of types

## Value

An
[`arrow::Schema`](https://arrow.apache.org/docs/r/reference/Schema-class.html)

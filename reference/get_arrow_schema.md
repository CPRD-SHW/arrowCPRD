# Create schema code for given names/types

Create schema code for given names/types

## Usage

``` r
get_arrow_schema(schema_in_names, schema_in_read_in_types)
```

## Arguments

- schema_in_names:

  A vector of column names

- schema_in_read_in_types:

  A vector of column types

## Value

A function for generating an
[`arrow::Schema`](https://arrow.apache.org/docs/r/reference/Schema-class.html)

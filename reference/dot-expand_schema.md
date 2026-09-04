# Expand a compact schema definition to a full schema

Expand a compact schema definition to a full schema

## Usage

``` r
.expand_schema(spec)
```

## Arguments

- spec:

  A schema list with `col_types` (a named character vector) and
  optionally `date_cols`.

## Value

A list with `names`, `read_in_types`, `date_cols` and an evaluated
`arrow_schema`.

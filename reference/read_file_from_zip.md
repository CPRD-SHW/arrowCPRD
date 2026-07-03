# Read a single file from a zip file (into a `data.table`)

Read a single file from a zip file (into a `data.table`)

## Usage

``` r
read_file_from_zip(zipfile, filename, schema = NULL, ...)
```

## Arguments

- zipfile:

  The Zip file to read from

- filename:

  Filename within Zip file

- schema:

  A list with 'names' and 'read_in_types'. If not provided these types
  will be automatically generated on reading files.

- ...:

  Additional arguments to
  [`data.table::fread`](https://rdrr.io/pkg/data.table/man/fread.html)

  Several schemas are included in the package and accessed by passing
  `dataset_name` and `table_name` to
  [`get_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/get_schema.md).
  You can use
  [`get_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/get_schema.md)
  with no arguments to list available schemas.

  You can also construct a custom schema using
  [`create_new_schema()`](https://cprd-shw.github.io/arrowCPRD/reference/create_new_schema.md)

## Value

A `data.table`

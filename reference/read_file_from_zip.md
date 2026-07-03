# Read a single file from a zip file (into a \`data.table\`)

Read a single file from a zip file (into a \`data.table\`)

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

  A list with 'names' and 'read_in_types'

- ...:

  Additional arguments to \`data.table::fread\`

## Value

A \`data.table\`

# Create a new schema for reading/writing CPRD to arrow

Create a new schema for reading/writing CPRD to arrow

## Usage

``` r
create_new_schema(col_names, col_types)
```

## Arguments

- col_names:

  A vector of column names in your dataset

- col_types:

  A vector of column types ("character", "integer", "numeric")

  Date types should be entered as "character" in the schema and will be
  cast to dates when writing to parquet

## Value

A list with attributes for a schema to be passed to other objects

## Examples

``` r
create_new_schema(
 col_names = c("name", "age", "birthdate"),
 col_types = c("character", "integer", "character")
)
#> $names
#> [1] "name"      "age"       "birthdate"
#> 
#> $read_in_types
#> [1] "character" "integer"   "character"
#> 
#> $arrow_schema
#> Schema
#> name: string
#> age: int32
#> birthdate: string
#> 
```

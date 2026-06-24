# Schemas for reading in Aurum data by types

Schemas for reading in Aurum data by types

## Usage

``` r
get_schema(
  dataset_name = c("aurum", "gold"),
  table_name = c("observation", "consultation", "patient", "staff", "drug", "linkage",
    "practice", "problem", "referral")
)
```

## Arguments

- dataset_name:

  Name of dataset - "aurum" or "gold"

- table_name:

  Name of table - "observation" etc.

## Value

A "schema" - a list of names of variables, r data types and arrow types

## Examples

``` r
# Not run
# get_schema("aurum", "observation")
# get_schema("aurum", "patient")
```

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
get_schema("aurum", "observation")
#> $names
#>  [1] "patid"        "consid"       "pracid"       "obsid"        "obsdate"     
#>  [6] "enterdate"    "staffid"      "parentobsid"  "medcodeid"    "value"       
#> [11] "numunitid"    "obstypeid"    "numrangelow"  "numrangehigh" "probobsid"   
#> 
#> $read_in_types
#>  [1] "character" "character" "integer"   "character" "character" "character"
#>  [7] "character" "character" "character" "numeric"   "integer"   "integer"  
#> [13] "numeric"   "numeric"   "character"
#> 
#> $arrow_schema
#> Schema
#> patid: string
#> consid: string
#> pracid: int64
#> obsid: string
#> obsdate: string
#> enterdate: string
#> staffid: string
#> parentobsid: string
#> medcodeid: string
#> value: double
#> numunitid: int64
#> obstypeid: int64
#> numrangelow: double
#> numrangehigh: double
#> probobsid: string
#> 
get_schema("aurum", "patient")
#> $names
#>  [1] "patid"          "pracid"         "usualgpstaffid" "gender"        
#>  [5] "yob"            "mob"            "emis_ddate"     "regstartdate"  
#>  [9] "patienttypeid"  "regenddate"     "acceptable"     "cprd_ddate"    
#> 
#> $read_in_types
#>  [1] "character" "integer"   "character" "integer"   "integer"   "integer"  
#>  [7] "character" "character" "integer"   "character" "integer"   "character"
#> 
#> $arrow_schema
#> Schema
#> patid: string
#> pracid: int64
#> usualgpstaffid: string
#> gender: int64
#> yob: int64
#> mob: int64
#> emis_ddate: string
#> regstartdate: string
#> patienttypeid: int64
#> regenddate: string
#> acceptable: int64
#> cprd_ddate: string
#> 
```

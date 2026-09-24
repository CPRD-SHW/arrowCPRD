# Schemas for reading in CPRD data by types

Linked data always uses `dataset_name = "linked"`, whatever database it
is linked to. Call with no arguments to list all available schemas.

## Usage

``` r
get_schema(dataset_name = NULL, table_name = NULL)
```

## Arguments

- dataset_name:

  Name of dataset - "aurum", "gold", or "linked"

- table_name:

  Name of table - "observation", "hes_patient" etc.

## Value

A "schema" - a list of names of variables, r data types and arrow types

## Examples

``` r
get_schema()
#> Please choose a dataset and table. Available schemas:
#> 
#> aurum:
#>   get_schema("aurum", "observation")
#>   get_schema("aurum", "patient")
#>   get_schema("aurum", "practice")
#>   get_schema("aurum", "problem")
#>   get_schema("aurum", "referral")
#>   get_schema("aurum", "drug")
#>   get_schema("aurum", "consultation")
#>   get_schema("aurum", "staff")
#> 
#> gold:
#>   get_schema("gold", "patient")
#>   get_schema("gold", "practice")
#>   get_schema("gold", "staff")
#>   get_schema("gold", "consultation")
#>   get_schema("gold", "clinical")
#>   get_schema("gold", "additional")
#>   get_schema("gold", "referral")
#>   get_schema("gold", "immunisation")
#>   get_schema("gold", "test")
#>   get_schema("gold", "therapy")
#> 
#> linked:
#>   get_schema("linked", "hes_patient")
#>   get_schema("linked", "hes_hospital")
#>   get_schema("linked", "hes_episodes")
#>   get_schema("linked", "hes_diagnosis_epi")
#>   get_schema("linked", "hes_diagnosis_hosp")
#>   get_schema("linked", "hes_primary_diag_hosp")
#>   get_schema("linked", "hes_procedures_epi")
#>   get_schema("linked", "hes_ccare")
#>   get_schema("linked", "hes_maternity")
#>   get_schema("linked", "hes_hrg")
#>   get_schema("linked", "hesop_patient")
#>   get_schema("linked", "hesop_patient_pathway")
#>   get_schema("linked", "hesop_appointment")
#>   get_schema("linked", "hesop_clinical")
#>   get_schema("linked", "hesop_operation")
#>   get_schema("linked", "hesae_patient")
#>   get_schema("linked", "hesae_attendance")
#>   get_schema("linked", "hesae_diagnosis")
#>   get_schema("linked", "hesae_investigation")
#>   get_schema("linked", "hesae_treatment")
#>   get_schema("linked", "hesae_hrg")
#>   get_schema("linked", "hesae_pathway")
#>   get_schema("linked", "hesdid_patient")
#>   get_schema("linked", "hesdid_referral")
#>   get_schema("linked", "hesdid_test")
#>   get_schema("linked", "deaths_patient")
#>   get_schema("linked", "dispensing")
#>   get_schema("linked", "practice_imd")
#>   get_schema("linked", "imd_domains")
#>   get_schema("linked", "practice_townsend2011")
#>   get_schema("linked", "practice_carstairs")
#>   get_schema("linked", "practice_urbanrural")
#>   get_schema("linked", "practice_subicbloc")
#>   get_schema("linked", "practice_coastal")
#>   get_schema("linked", "cancer_tumour")
#>   get_schema("linked", "cancer_treatment")
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
#> $date_cols
#> [1] "obsdate"   "enterdate"
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
get_schema("linked", "hes_patient")
#> $names
#> [1] "patid"         "pracid"        "cprd_mpsid"    "gen_ethnicity"
#> 
#> $read_in_types
#> [1] "character" "character" "integer"   "character"
#> 
#> $date_cols
#> NULL
#> 
#> $arrow_schema
#> Schema
#> patid: string
#> pracid: string
#> cprd_mpsid: int64
#> gen_ethnicity: string
#> 
```

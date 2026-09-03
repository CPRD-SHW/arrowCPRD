# Linked data table schemas - HES DID
.schemas_linked_hes_did <- list(

  linked_hesdid_patient = list(
    names = c(
      "patid",
      "pracid",
      "gen_hesid",
      "n_patid_hes",
      "match_rank"
    ),

    read_in_types = c(
      "character",
      "character",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        pracid = arrow::utf8(),
        gen_hesid = arrow::int64(),
        n_patid_hes = arrow::int64(),
        match_rank = arrow::int64()
      )
    )
  ),


  linked_hesdid_referral = list(
    date_cols = c("did_date1", "did_date2"),

    names = c(
      "patid",
      "submissiondataid",
      "did_ethcat",
      "ic_reftype_desc",
      "ic_prov_shacode",
      "did_patsource_code",
      "did_date1",
      "did_date2",
      "hes_did_matchrank"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "character",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        submissiondataid = arrow::int64(),
        did_ethcat = arrow::utf8(),
        ic_reftype_desc = arrow::utf8(),
        ic_prov_shacode = arrow::utf8(),
        did_patsource_code = arrow::int64(),
        did_date1 = arrow::utf8(),
        did_date2 = arrow::utf8(),
        hes_did_matchrank = arrow::utf8()
      )
    )
  ),


  linked_hesdid_test = list(
    date_cols = c("did_date3", "did_date4"),

    names = c(
      "patid",
      "submissiondataid",
      "fyear",
      "did_date3",
      "did_date4",
      "did_nicip_code",
      "did_snomedct_code",
      "ic_modality_id",
      "ic_sub_modality_id",
      "ic_region_id",
      "ic_sub_region_id",
      "ic_system_id",
      "ic_sub_sys_id",
      "ic_sub_syscomp_id",
      "ic_morhpology_id",
      "ic_fetal_id",
      "ic_cancer_desc",
      "ic_sub_cancer_desc"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        submissiondataid = arrow::int64(),
        fyear = arrow::int64(),
        did_date3 = arrow::utf8(),
        did_date4 = arrow::utf8(),
        did_nicip_code = arrow::utf8(),
        did_snomedct_code = arrow::int64(),
        ic_modality_id = arrow::int64(),
        ic_sub_modality_id = arrow::int64(),
        ic_region_id = arrow::int64(),
        ic_sub_region_id = arrow::int64(),
        ic_system_id = arrow::int64(),
        ic_sub_sys_id = arrow::int64(),
        ic_sub_syscomp_id = arrow::int64(),
        ic_morhpology_id = arrow::int64(),
        ic_fetal_id = arrow::int64(),
        ic_cancer_desc = arrow::utf8(),
        ic_sub_cancer_desc = arrow::utf8()
      )
    )
  )
)

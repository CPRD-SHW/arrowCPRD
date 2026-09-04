# Aurum table schemas
.schemas_aurum <- list(
  aurum_observation = list(
    date_cols = c("obsdate", "enterdate"),

    col_types = c(
      patid = "character",
      consid = "character",
      pracid = "integer",
      obsid = "character",
      obsdate = "character",
      enterdate = "character",
      staffid = "character",
      parentobsid = "character",
      medcodeid = "character",
      value = "numeric",
      numunitid = "integer",
      obstypeid = "integer",
      numrangelow = "numeric",
      numrangehigh = "numeric",
      probobsid = "character"
    )
  ),


  aurum_patient = list(
    date_cols = c("emis_ddate", "regstartdate", "regenddate", "cprd_ddate"),

    col_types = c(
      patid = "character",
      pracid = "integer",
      usualgpstaffid = "character",
      gender = "integer",
      yob = "integer",
      mob = "integer",
      emis_ddate = "character",
      regstartdate = "character",
      patienttypeid = "integer",
      regenddate = "character",
      acceptable = "integer",
      cprd_ddate = "character"
    )
  ),


  aurum_practice = list(
    date_cols = c("lcd", "uts"),

    col_types = c(
      pracid = "integer",
      lcd = "character",
      uts = "character",
      region = "integer"
    )
  ),


  aurum_problem = list(
    date_cols = c("probenddate", "lastrevdate"),

    col_types = c(
      patid = "character",
      obsid = "character",
      pracid = "integer",
      parentprobobsid = "character",
      probenddate = "character",
      expduration = "integer",
      lastrevdate = "character",
      lastrevstaffid = "character",
      parentprobrelid = "integer",
      probstatusid = "integer",
      signid = "integer"
    )
  ),



  aurum_referral = list(
    col_types = c(
      patid = "character",
      obsid = "character",
      pracid = "integer",
      refsourceorgid = "integer",
      reftargetorgid = "integer",
      refurgencyid = "integer",
      refservicetypeid = "integer",
      refmodeid = "integer"
    )
  ),


  aurum_drug = list(
    date_cols = c("issuedate", "enterdate"),

    col_types = c(
      patid = "character",
      issueid = "character",
      pracid = "integer",
      probobsid = "character",
      drugrecid = "character",
      issuedate = "character",
      enterdate = "character",
      staffid = "character",
      prodcodeid = "character",
      dosageid = "character",
      quantity = "numeric",
      quantunitid = "integer",
      duration = "integer",
      estnhscost = "numeric"
    )
  ),


  aurum_consultation = list(
    date_cols = c("consdate", "enterdate"),

    col_types = c(
      patid = "character",
      consid = "character",
      pracid = "integer",
      consdate = "character",
      enterdate = "character",
      staffid = "character",
      conssourceid = "character",
      cprdconstype = "integer",
      consmedcodeid = "character"
    )
  ),


  aurum_staff = list(
    col_types = c(
      staffid = "character",
      pracid = "character",
      jobcatid = "character"
    )
  )
)

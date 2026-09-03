# GOLD table schemas
.schemas_gold <- list(
  gold_patient = list(
    date_cols = c("chsdate", "frd", "crd", "tod", "deathdate"),

    col_types = c(
      patid = "character",
      vmid = "integer",
      gender = "integer",
      yob = "integer",
      mob = "integer",
      marital = "integer",
      famnum = "integer",
      chsreg = "integer",
      chsdate = "character",
      prescr = "integer",
      capsup = "integer",
      frd = "character",
      crd = "character",
      regstat = "integer",
      reggap = "integer",
      internal = "integer",
      tod = "character",
      toreason = "integer",
      deathdate = "character",
      accept = "integer"
    )
  ),


  gold_practice = list(
    date_cols = c("lcd", "uts"),

    col_types = c(
      pracid = "character",
      region = "integer",
      lcd = "character",
      uts = "character"
    )
  ),


  gold_staff = list(
    col_types = c(
      staffid = "integer",
      gender = "integer",
      role = "integer"
    )
  ),


  gold_consultation = list(
    date_cols = c("eventdate", "sysdate"),

    col_types = c(
      patid = "character",
      eventdate = "character",
      sysdate = "character",
      constype = "integer",
      consid = "integer",
      staffid = "integer",
      duration = "integer"
    )
  ),


  gold_clinical = list(
    date_cols = c("eventdate", "sysdate"),

    col_types = c(
      patid = "character",
      eventdate = "character",
      sysdate = "character",
      constype = "integer",
      consid = "integer",
      medcode = "integer",
      sctid = "character",
      sctdescid = "character",
      sctexpression = "character",
      sctmaptype = "integer",
      sctmapversion = "integer",
      sctisindicative = "logical",
      sctisassured = "logical",
      staffid = "integer",
      episode = "integer",
      enttype = "integer",
      adid = "integer"
    )
  ),


  gold_additional = list(
    col_types = c(
      patid = "character",
      enttype = "integer",
      adid = "integer",
      data1 = "character",
      data2 = "character",
      data3 = "character",
      data4 = "character",
      data5 = "character",
      data6 = "character",
      data7 = "character",
      data8 = "character",
      data9 = "character",
      data10 = "character",
      data11 = "character",
      data12 = "character"
    )
  ),


  gold_referral = list(
    date_cols = c("eventdate", "sysdate"),

    col_types = c(
      patid = "character",
      eventdate = "character",
      sysdate = "character",
      constype = "integer",
      consid = "integer",
      medcode = "integer",
      sctid = "character",
      sctdescid = "character",
      sctexpression = "character",
      sctmaptype = "integer",
      sctmapversion = "integer",
      sctisindicative = "logical",
      sctisassured = "logical",
      staffid = "integer",
      source = "integer",
      nhsspec = "integer",
      fhsaspec = "integer",
      inpatient = "integer",
      attendance = "integer",
      urgency = "integer"
    )
  ),


  gold_immunisation = list(
    date_cols = c("eventdate", "sysdate"),

    col_types = c(
      patid = "character",
      eventdate = "character",
      sysdate = "character",
      constype = "integer",
      consid = "integer",
      medcode = "integer",
      sctid = "character",
      sctdescid = "character",
      sctexpression = "character",
      sctmaptype = "integer",
      sctmapversion = "integer",
      sctisindicative = "logical",
      sctisassured = "logical",
      staffid = "integer",
      immstype = "integer",
      stage = "integer",
      status = "integer",
      compound = "integer",
      source = "integer",
      reason = "integer",
      method = "integer",
      batch = "integer"
    )
  ),


  gold_test = list(
    date_cols = c("eventdate", "sysdate"),

    col_types = c(
      patid = "character",
      eventdate = "character",
      sysdate = "character",
      constype = "integer",
      consid = "integer",
      medcode = "integer",
      sctid = "character",
      sctdescid = "character",
      sctexpression = "character",
      sctmaptype = "integer",
      sctmapversion = "integer",
      sctisindicative = "logical",
      sctisassured = "logical",
      staffid = "integer",
      enttype = "integer",
      data1 = "character",
      data2 = "character",
      data3 = "character",
      data4 = "character",
      data5 = "character",
      data6 = "character",
      data7 = "character",
      data8 = "character"
    )
  ),


  gold_therapy = list(
    date_cols = c("eventdate", "sysdate"),

    col_types = c(
      patid = "character",
      eventdate = "character",
      sysdate = "character",
      consid = "integer",
      prodcode = "integer",
      drugdmd = "character",
      staffid = "integer",
      dosageid = "character",
      bnfcode = "integer",
      qty = "integer",
      numdays = "integer",
      numpacks = "integer",
      packtype = "integer",
      issueseq = "integer",
      prn = "integer"
    )
  )
)

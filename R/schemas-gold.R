# GOLD table schemas
.schemas_gold <- list(
  gold_patient = list(
    date_cols = c("chsdate", "frd", "crd", "tod", "deathdate"),

    names = c(
      "patid",
      "vmid",
      "gender",
      "yob",
      "mob",
      "marital",
      "famnum",
      "chsreg",
      "chsdate",
      "prescr",
      "capsup",
      "frd",
      "crd",
      "regstat",
      "reggap",
      "internal",
      "tod",
      "toreason",
      "deathdate",
      "accept"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "character",
      "integer",
      "integer",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "integer",
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        vmid = arrow::int64(),
        gender = arrow::int64(),
        yob = arrow::int64(),
        mob = arrow::int64(),
        marital = arrow::int64(),
        famnum = arrow::int64(),
        chsreg = arrow::int64(),
        chsdate = arrow::utf8(),
        prescr = arrow::int64(),
        capsup = arrow::int64(),
        frd = arrow::utf8(),
        crd = arrow::utf8(),
        regstat = arrow::int64(),
        reggap = arrow::int64(),
        internal = arrow::int64(),
        tod = arrow::utf8(),
        toreason = arrow::int64(),
        deathdate = arrow::utf8(),
        accept = arrow::int64()
      )
    )
  ),


  gold_practice = list(
    date_cols = c("lcd", "uts"),

    names = c("pracid", "region", "lcd", "uts"),

    read_in_types = c("integer", "integer", "character", "character"),

    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::int64(),
        region = arrow::int64(),
        lcd = arrow::utf8(),
        uts = arrow::utf8()
      )
    )
  ),


  gold_staff = list(
    names = c("staffid", "gender", "role"),

    read_in_types = c("integer", "integer", "integer"),

    arrow_schema = quote(
      arrow::schema(
        staffid = arrow::int64(),
        gender = arrow::int64(),
        role = arrow::int64()
      )
    )
  ),


  gold_consultation = list(
    date_cols = c("eventdate", "sysdate"),

    names = c(
      "patid",
      "eventdate",
      "sysdate",
      "constype",
      "consid",
      "staffid",
      "duration"
    ),

    read_in_types = c(
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        eventdate = arrow::utf8(),
        sysdate = arrow::utf8(),
        constype = arrow::int64(),
        consid = arrow::int64(),
        staffid = arrow::int64(),
        duration = arrow::int64()
      )
    )
  ),


  gold_clinical = list(
    date_cols = c("eventdate", "sysdate"),

    names = c(
      "patid",
      "eventdate",
      "sysdate",
      "constype",
      "consid",
      "medcode",
      "sctid",
      "sctdescid",
      "sctexpression",
      "sctmaptype",
      "sctmapversion",
      "sctisindicative",
      "sctisassured",
      "staffid",
      "episode",
      "enttype",
      "adid"
    ),

    read_in_types = c(
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "logical",
      "logical",
      "integer",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        eventdate = arrow::utf8(),
        sysdate = arrow::utf8(),
        constype = arrow::int64(),
        consid = arrow::int64(),
        medcode = arrow::int64(),
        sctid = arrow::utf8(),
        sctdescid = arrow::utf8(),
        sctexpression = arrow::utf8(),
        sctmaptype = arrow::int64(),
        sctmapversion = arrow::int64(),
        sctisindicative = arrow::bool(),
        sctisassured = arrow::bool(),
        staffid = arrow::int64(),
        episode = arrow::int64(),
        enttype = arrow::int64(),
        adid = arrow::int64()
      )
    )
  ),


  gold_additional = list(
    names = c(
      "patid",
      "enttype",
      "adid",
      "data1",
      "data2",
      "data3",
      "data4",
      "data5",
      "data6",
      "data7",
      "data8",
      "data9",
      "data10",
      "data11",
      "data12"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        enttype = arrow::int64(),
        adid = arrow::int64(),
        data1 = arrow::utf8(),
        data2 = arrow::utf8(),
        data3 = arrow::utf8(),
        data4 = arrow::utf8(),
        data5 = arrow::utf8(),
        data6 = arrow::utf8(),
        data7 = arrow::utf8(),
        data8 = arrow::utf8(),
        data9 = arrow::utf8(),
        data10 = arrow::utf8(),
        data11 = arrow::utf8(),
        data12 = arrow::utf8()
      )
    )
  ),


  gold_referral = list(
    date_cols = c("eventdate", "sysdate"),

    names = c(
      "patid",
      "eventdate",
      "sysdate",
      "constype",
      "consid",
      "medcode",
      "sctid",
      "sctdescid",
      "sctexpression",
      "sctmaptype",
      "sctmapversion",
      "sctisindicative",
      "sctisassured",
      "staffid",
      "source",
      "nhsspec",
      "fhsaspec",
      "inpatient",
      "attendance",
      "urgency"
    ),

    read_in_types = c(
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "logical",
      "logical",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        eventdate = arrow::utf8(),
        sysdate = arrow::utf8(),
        constype = arrow::int64(),
        consid = arrow::int64(),
        medcode = arrow::int64(),
        sctid = arrow::utf8(),
        sctdescid = arrow::utf8(),
        sctexpression = arrow::utf8(),
        sctmaptype = arrow::int64(),
        sctmapversion = arrow::int64(),
        sctisindicative = arrow::bool(),
        sctisassured = arrow::bool(),
        staffid = arrow::int64(),
        source = arrow::int64(),
        nhsspec = arrow::int64(),
        fhsaspec = arrow::int64(),
        inpatient = arrow::int64(),
        attendance = arrow::int64(),
        urgency = arrow::int64()
      )
    )
  ),


  gold_immunisation = list(
    date_cols = c("eventdate", "sysdate"),

    names = c(
      "patid",
      "eventdate",
      "sysdate",
      "constype",
      "consid",
      "medcode",
      "sctid",
      "sctdescid",
      "sctexpression",
      "sctmaptype",
      "sctmapversion",
      "sctisindicative",
      "sctisassured",
      "staffid",
      "immstype",
      "stage",
      "status",
      "compound",
      "source",
      "reason",
      "method",
      "batch"
    ),

    read_in_types = c(
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "logical",
      "logical",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        eventdate = arrow::utf8(),
        sysdate = arrow::utf8(),
        constype = arrow::int64(),
        consid = arrow::int64(),
        medcode = arrow::int64(),
        sctid = arrow::utf8(),
        sctdescid = arrow::utf8(),
        sctexpression = arrow::utf8(),
        sctmaptype = arrow::int64(),
        sctmapversion = arrow::int64(),
        sctisindicative = arrow::bool(),
        sctisassured = arrow::bool(),
        staffid = arrow::int64(),
        immstype = arrow::int64(),
        stage = arrow::int64(),
        status = arrow::int64(),
        compound = arrow::int64(),
        source = arrow::int64(),
        reason = arrow::int64(),
        method = arrow::int64(),
        batch = arrow::int64()
      )
    )
  ),


  gold_test = list(
    date_cols = c("eventdate", "sysdate"),

    names = c(
      "patid",
      "eventdate",
      "sysdate",
      "constype",
      "consid",
      "medcode",
      "sctid",
      "sctdescid",
      "sctexpression",
      "sctmaptype",
      "sctmapversion",
      "sctisindicative",
      "sctisassured",
      "staffid",
      "enttype",
      "data1",
      "data2",
      "data3",
      "data4",
      "data5",
      "data6",
      "data7",
      "data8"
    ),

    read_in_types = c(
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "logical",
      "logical",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        eventdate = arrow::utf8(),
        sysdate = arrow::utf8(),
        constype = arrow::int64(),
        consid = arrow::int64(),
        medcode = arrow::int64(),
        sctid = arrow::utf8(),
        sctdescid = arrow::utf8(),
        sctexpression = arrow::utf8(),
        sctmaptype = arrow::int64(),
        sctmapversion = arrow::int64(),
        sctisindicative = arrow::bool(),
        sctisassured = arrow::bool(),
        staffid = arrow::int64(),
        enttype = arrow::int64(),
        data1 = arrow::utf8(),
        data2 = arrow::utf8(),
        data3 = arrow::utf8(),
        data4 = arrow::utf8(),
        data5 = arrow::utf8(),
        data6 = arrow::utf8(),
        data7 = arrow::utf8(),
        data8 = arrow::utf8()
      )
    )
  ),


  gold_therapy = list(
    date_cols = c("eventdate", "sysdate"),

    names = c(
      "patid",
      "eventdate",
      "sysdate",
      "consid",
      "prodcode",
      "drugdmd",
      "staffid",
      "dosageid",
      "bnfcode",
      "qty",
      "numdays",
      "numpacks",
      "packtype",
      "issueseq",
      "prn"
    ),

    read_in_types = c(
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "character",
      "integer",
      "character",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        eventdate = arrow::utf8(),
        sysdate = arrow::utf8(),
        consid = arrow::int64(),
        prodcode = arrow::int64(),
        drugdmd = arrow::utf8(),
        staffid = arrow::int64(),
        dosageid = arrow::utf8(),
        bnfcode = arrow::int64(),
        qty = arrow::int64(),
        numdays = arrow::int64(),
        numpacks = arrow::int64(),
        packtype = arrow::int64(),
        issueseq = arrow::int64(),
        prn = arrow::int64()
      )
    )
  )
)

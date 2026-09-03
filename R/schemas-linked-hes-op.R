# Linked data table schemas - HES OP
.schemas_linked_hes_op <- list(

  linked_hesop_patient = list(
    names = c(
      "patid",
      "pracid",
      "cprd_mpsid",
      "gen_ethnicity"
    ),

    read_in_types = c(
      "character",
      "character",
      "integer",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        pracid = arrow::utf8(),
        cprd_mpsid = arrow::int64(),
        gen_ethnicity = arrow::utf8()
      )
    )
  ),


  linked_hesop_patient_pathway = list(
    date_cols = c("subdate"),

    names = c(
      "patid",
      "attendkey",
      "subdate"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        attendkey = arrow::int64(),
        subdate = arrow::utf8()
      )
    )
  ),


  linked_hesop_appointment = list(
    date_cols = c("apptdate", "dnadate", "reqdate"),

    names = c(
      "patid",
      "attendkey",
      "ethnos",
      "admincat",
      "apptdate",
      "apptage",
      "atentype",
      "attended",
      "dnadate",
      "firstatt",
      "outcome",
      "priority",
      "refsourc",
      "reqdate",
      "servtype",
      "stafftyp",
      "wait_ind",
      "waiting"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "integer",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "integer",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        attendkey = arrow::int64(),
        ethnos = arrow::utf8(),
        admincat = arrow::int64(),
        apptdate = arrow::utf8(),
        apptage = arrow::int64(),
        atentype = arrow::int64(),
        attended = arrow::int64(),
        dnadate = arrow::utf8(),
        firstatt = arrow::utf8(),
        outcome = arrow::int64(),
        priority = arrow::int64(),
        refsourc = arrow::int64(),
        reqdate = arrow::utf8(),
        servtype = arrow::int64(),
        stafftyp = arrow::int64(),
        wait_ind = arrow::int64(),
        waiting = arrow::int64()
      )
    )
  ),


  linked_hesop_clinical = list(
    names = c(
      "patid",
      "attendkey",
      "diagnosis",
      "icdx",
      "icd",
      "diag_order",
      "tretspef",
      "mainspef"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        attendkey = arrow::int64(),
        diagnosis = arrow::utf8(),
        icdx = arrow::utf8(),
        icd = arrow::utf8(),
        diag_order = arrow::int64(),
        tretspef = arrow::utf8(),
        mainspef = arrow::utf8()
      )
    )
  ),


  linked_hesop_operation = list(
    names = c(
      "patid",
      "attendkey",
      "operation",
      "opcs",
      "opertn_order",
      "operstat",
      "tretspef",
      "mainspef"
    ),

    read_in_types = c(
      "character",
      "integer",
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
        attendkey = arrow::int64(),
        operation = arrow::utf8(),
        opcs = arrow::utf8(),
        opertn_order = arrow::int64(),
        operstat = arrow::utf8(),
        tretspef = arrow::utf8(),
        mainspef = arrow::utf8()
      )
    )
  )
)

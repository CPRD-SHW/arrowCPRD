# Linked data table schemas - HES A&E
.schemas_linked_hes_ae <- list(

  linked_hesae_patient = list(
    names = c(
      "patid",
      "pracid",
      "gen_ethnicity",
      "cprd_mpsid",
      "match_rank"
    ),

    read_in_types = c(
      "character",
      "character",
      "character",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        pracid = arrow::utf8(),
        gen_ethnicity = arrow::utf8(),
        cprd_mpsid = arrow::int64(),
        match_rank = arrow::int64()
      )
    )
  ),


  linked_hesae_attendance = list(
    date_cols = c("arrivaldate"),

    names = c(
      "patid",
      "aekey",
      "arrivaldate",
      "aepatgroup",
      "aeattendcat",
      "aearrivalmode",
      "aedepttype",
      "aerefsource",
      "aeincloctype",
      "aeattenddisp",
      "initdur",
      "tretdur",
      "concldur",
      "depdur",
      "ethnos"
    ),

    read_in_types = c(
      "character",
      "integer",
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
      "integer",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        aekey = arrow::int64(),
        arrivaldate = arrow::utf8(),
        aepatgroup = arrow::int64(),
        aeattendcat = arrow::int64(),
        aearrivalmode = arrow::int64(),
        aedepttype = arrow::int64(),
        aerefsource = arrow::int64(),
        aeincloctype = arrow::int64(),
        aeattenddisp = arrow::int64(),
        initdur = arrow::int64(),
        tretdur = arrow::int64(),
        concldur = arrow::int64(),
        depdur = arrow::int64(),
        ethnos = arrow::utf8()
      )
    )
  ),


  linked_hesae_diagnosis = list(
    names = c(
      "patid",
      "aekey",
      "diag",
      "diag2",
      "diag3",
      "diaga",
      "diags",
      "diagscheme",
      "diag_order"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        aekey = arrow::int64(),
        diag = arrow::utf8(),
        diag2 = arrow::utf8(),
        diag3 = arrow::utf8(),
        diaga = arrow::utf8(),
        diags = arrow::utf8(),
        diagscheme = arrow::utf8(),
        diag_order = arrow::int64()
      )
    )
  ),


  linked_hesae_investigation = list(
    names = c(
      "patid",
      "aekey",
      "invest",
      "invest2",
      "invest_order"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        aekey = arrow::int64(),
        invest = arrow::utf8(),
        invest2 = arrow::utf8(),
        invest_order = arrow::int64()
      )
    )
  ),


  linked_hesae_treatment = list(
    names = c(
      "patid",
      "aekey",
      "treat",
      "treat2",
      "treat3",
      "treat_order"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        aekey = arrow::int64(),
        treat = arrow::utf8(),
        treat2 = arrow::utf8(),
        treat3 = arrow::utf8(),
        treat_order = arrow::int64()
      )
    )
  ),


  linked_hesae_hrg = list(
    names = c(
      "patid",
      "aekey",
      "domproc",
      "hrgnhs",
      "hrgnhsvn",
      "sushrg",
      "sushrgvers"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "numeric"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        aekey = arrow::int64(),
        domproc = arrow::utf8(),
        hrgnhs = arrow::utf8(),
        hrgnhsvn = arrow::utf8(),
        sushrg = arrow::utf8(),
        sushrgvers = arrow::float64()
      )
    )
  ),


  linked_hesae_pathway = list(
    date_cols = c("rttperstart", "rttperend"),

    names = c(
      "patid",
      "aekey",
      "rttperstart",
      "rttperend"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        aekey = arrow::int64(),
        rttperstart = arrow::utf8(),
        rttperend = arrow::utf8()
      )
    )
  )
)

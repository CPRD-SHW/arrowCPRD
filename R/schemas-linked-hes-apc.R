# Linked data table schemas - HES APC
.schemas_linked_hes_apc <- list(

  linked_hes_patient = list(
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


  linked_hes_hospital = list(
    date_cols = c("admidate", "discharged", "elecdate"),

    names = c(
      "patid",
      "spno",
      "admidate",
      "discharged",
      "admimeth",
      "admisorc",
      "disdest",
      "dismeth",
      "duration",
      "elecdate",
      "elecdur"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "integer",
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        admidate = arrow::utf8(),
        discharged = arrow::utf8(),
        admimeth = arrow::utf8(),
        admisorc = arrow::int64(),
        disdest = arrow::int64(),
        dismeth = arrow::int64(),
        duration = arrow::int64(),
        elecdate = arrow::utf8(),
        elecdur = arrow::int64()
      )
    )
  ),


  linked_hes_episodes = list(
    date_cols = c("admidate", "epistart", "epiend", "discharged"),

    names = c(
      "patid",
      "spno",
      "epikey",
      "admidate",
      "epistart",
      "epiend",
      "discharged",
      "eorder",
      "epidur",
      "epitype",
      "admimeth",
      "admisorc",
      "disdest",
      "dismeth",
      "mainspef",
      "tretspef",
      "pconsult",
      "intmanig",
      "classpat",
      "firstreg",
      "ethnos"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "integer",
      "integer",
      "integer",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        epikey = arrow::int64(),
        admidate = arrow::utf8(),
        epistart = arrow::utf8(),
        epiend = arrow::utf8(),
        discharged = arrow::utf8(),
        eorder = arrow::int64(),
        epidur = arrow::int64(),
        epitype = arrow::int64(),
        admimeth = arrow::utf8(),
        admisorc = arrow::int64(),
        disdest = arrow::int64(),
        dismeth = arrow::int64(),
        mainspef = arrow::utf8(),
        tretspef = arrow::utf8(),
        pconsult = arrow::utf8(),
        intmanig = arrow::int64(),
        classpat = arrow::int64(),
        firstreg = arrow::int64(),
        ethnos = arrow::utf8()
      )
    )
  ),


  linked_hes_diagnosis_epi = list(
    date_cols = c("epistart", "epiend"),

    names = c(
      "patid",
      "spno",
      "epikey",
      "epistart",
      "epiend",
      "ICD",
      "ICDx",
      "d_order"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        epikey = arrow::int64(),
        epistart = arrow::utf8(),
        epiend = arrow::utf8(),
        ICD = arrow::utf8(),
        ICDx = arrow::utf8(),
        d_order = arrow::int64()
      )
    )
  ),


  linked_hes_diagnosis_hosp = list(
    date_cols = c("admidate", "discharged"),

    names = c(
      "patid",
      "spno",
      "admidate",
      "discharged",
      "ICD",
      "ICDx"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        admidate = arrow::utf8(),
        discharged = arrow::utf8(),
        ICD = arrow::utf8(),
        ICDx = arrow::utf8()
      )
    )
  ),


  linked_hes_primary_diag_hosp = list(
    date_cols = c("admidate", "discharged"),

    names = c(
      "patid",
      "spno",
      "admidate",
      "discharged",
      "ICD_PRIMARY",
      "ICDx"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "character",
      "character",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        admidate = arrow::utf8(),
        discharged = arrow::utf8(),
        ICD_PRIMARY = arrow::utf8(),
        ICDx = arrow::utf8()
      )
    )
  ),


  linked_hes_procedures_epi = list(
    date_cols = c("admidate", "epistart", "epiend", "discharged", "evdate"),

    names = c(
      "patid",
      "spno",
      "epikey",
      "admidate",
      "epistart",
      "epiend",
      "discharged",
      "OPCS",
      "evdate",
      "p_order"
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
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        epikey = arrow::int64(),
        admidate = arrow::utf8(),
        epistart = arrow::utf8(),
        epiend = arrow::utf8(),
        discharged = arrow::utf8(),
        OPCS = arrow::utf8(),
        evdate = arrow::utf8(),
        p_order = arrow::int64()
      )
    )
  ),


  linked_hes_ccare = list(
    date_cols = c("admidate", "discharged", "epistart", "epiend",
                  "ccstartdate", "ccdisrdydate", "ccdisdate"),

    names = c(
      "patid",
      "spno",
      "epikey",
      "admidate",
      "discharged",
      "epistart",
      "epiend",
      "eorder",
      "ccstartdate",
      "ccstarttime",
      "ccdisrdydate",
      "ccdisrdytime",
      "ccdisdate",
      "ccdistime",
      "ccadmitype",
      "ccadmisorc",
      "ccsorcloc",
      "ccdisstat",
      "ccdisdest",
      "ccdisloc",
      "cclev2days",
      "cclev3days",
      "bcardsupdays",
      "acardsupdays",
      "bressupdays",
      "aressupdays",
      "gisupdays",
      "liversupdays",
      "neurosupdays",
      "rensupdays",
      "dermsupdays",
      "orgsupmax",
      "ccunitfun",
      "unitbedconfig",
      "bestmatch",
      "ccapcrel"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "integer",
      "character",
      "character",
      "character",
      "character",
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
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        epikey = arrow::int64(),
        admidate = arrow::utf8(),
        discharged = arrow::utf8(),
        epistart = arrow::utf8(),
        epiend = arrow::utf8(),
        eorder = arrow::int64(),
        ccstartdate = arrow::utf8(),
        ccstarttime = arrow::utf8(),
        ccdisrdydate = arrow::utf8(),
        ccdisrdytime = arrow::utf8(),
        ccdisdate = arrow::utf8(),
        ccdistime = arrow::utf8(),
        ccadmitype = arrow::utf8(),
        ccadmisorc = arrow::int64(),
        ccsorcloc = arrow::int64(),
        ccdisstat = arrow::int64(),
        ccdisdest = arrow::int64(),
        ccdisloc = arrow::int64(),
        cclev2days = arrow::int64(),
        cclev3days = arrow::int64(),
        bcardsupdays = arrow::int64(),
        acardsupdays = arrow::int64(),
        bressupdays = arrow::int64(),
        aressupdays = arrow::int64(),
        gisupdays = arrow::int64(),
        liversupdays = arrow::int64(),
        neurosupdays = arrow::int64(),
        rensupdays = arrow::int64(),
        dermsupdays = arrow::int64(),
        orgsupmax = arrow::int64(),
        ccunitfun = arrow::int64(),
        unitbedconfig = arrow::int64(),
        bestmatch = arrow::int64(),
        ccapcrel = arrow::int64()
      )
    )
  ),


  linked_hes_maternity = list(
    date_cols = c("epistart", "epiend", "anasdate"),

    names = c(
      "patid",
      "spno",
      "epikey",
      "epistart",
      "epiend",
      "eorder",
      "epidur",
      "numbaby",
      "numtailb",
      "matordr",
      "neocare",
      "wellbaby",
      "anasdate",
      "birordr",
      "birstat",
      "biresus",
      "sexbaby",
      "birweit",
      "delmeth",
      "delonset",
      "delinten",
      "delplac",
      "delchang",
      "delprean",
      "delposan",
      "delstat",
      "anagest",
      "gestat",
      "numpreg",
      "matage",
      "neodur",
      "antedur",
      "postdur"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "character",
      "character",
      "integer",
      "integer",
      "character",
      "integer",
      "integer",
      "integer",
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
        spno = arrow::int64(),
        epikey = arrow::int64(),
        epistart = arrow::utf8(),
        epiend = arrow::utf8(),
        eorder = arrow::int64(),
        epidur = arrow::int64(),
        numbaby = arrow::utf8(),
        numtailb = arrow::int64(),
        matordr = arrow::int64(),
        neocare = arrow::int64(),
        wellbaby = arrow::utf8(),
        anasdate = arrow::utf8(),
        birordr = arrow::utf8(),
        birstat = arrow::int64(),
        biresus = arrow::int64(),
        sexbaby = arrow::utf8(),
        birweit = arrow::int64(),
        delmeth = arrow::utf8(),
        delonset = arrow::int64(),
        delinten = arrow::int64(),
        delplac = arrow::int64(),
        delchang = arrow::int64(),
        delprean = arrow::int64(),
        delposan = arrow::int64(),
        delstat = arrow::int64(),
        anagest = arrow::int64(),
        gestat = arrow::int64(),
        numpreg = arrow::int64(),
        matage = arrow::int64(),
        neodur = arrow::int64(),
        antedur = arrow::int64(),
        postdur = arrow::int64()
      )
    )
  ),


  linked_hes_hrg = list(
    names = c(
      "patid",
      "spno",
      "epikey",
      "domproc",
      "hrglate35",
      "hrgnhs",
      "hrgnhsvn",
      "suscorehrg",
      "sushrg",
      "sushrgvers",
      "hes_yr"
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
      "numeric",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        spno = arrow::int64(),
        epikey = arrow::int64(),
        domproc = arrow::utf8(),
        hrglate35 = arrow::utf8(),
        hrgnhs = arrow::utf8(),
        hrgnhsvn = arrow::utf8(),
        suscorehrg = arrow::utf8(),
        sushrg = arrow::utf8(),
        sushrgvers = arrow::float64(),
        hes_yr = arrow::int64()
      )
    )
  )
)

# Linked data table schemas

# HES APC
.schemas_linked_hes_apc <- list(

  linked_hes_patient = list(
    col_types = c(
      patid = "character",
      pracid = "character",
      cprd_mpsid = "integer",
      gen_ethnicity = "character"
    )
  ),


  linked_hes_hospital = list(
    date_cols = c("admidate", "discharged", "elecdate"),

    col_types = c(
      patid = "character",
      spno = "integer",
      admidate = "character",
      discharged = "character",
      admimeth = "character",
      admisorc = "integer",
      disdest = "integer",
      dismeth = "integer",
      duration = "integer",
      elecdate = "character",
      elecdur = "integer"
    )
  ),


  linked_hes_episodes = list(
    date_cols = c("admidate", "epistart", "epiend", "discharged"),

    col_types = c(
      patid = "character",
      spno = "integer",
      epikey = "integer",
      admidate = "character",
      epistart = "character",
      epiend = "character",
      discharged = "character",
      eorder = "integer",
      epidur = "integer",
      epitype = "integer",
      admimeth = "character",
      admisorc = "integer",
      disdest = "integer",
      dismeth = "integer",
      mainspef = "character",
      tretspef = "character",
      pconsult = "character",
      intmanig = "integer",
      classpat = "integer",
      firstreg = "integer",
      ethnos = "character"
    )
  ),


  linked_hes_diagnosis_epi = list(
    date_cols = c("epistart", "epiend"),

    col_types = c(
      patid = "character",
      spno = "integer",
      epikey = "integer",
      epistart = "character",
      epiend = "character",
      ICD = "character",
      ICDx = "character",
      d_order = "integer"
    )
  ),


  linked_hes_diagnosis_hosp = list(
    date_cols = c("admidate", "discharged"),

    col_types = c(
      patid = "character",
      spno = "integer",
      admidate = "character",
      discharged = "character",
      ICD = "character",
      ICDx = "character"
    )
  ),


  linked_hes_primary_diag_hosp = list(
    date_cols = c("admidate", "discharged"),

    col_types = c(
      patid = "character",
      spno = "integer",
      admidate = "character",
      discharged = "character",
      ICD_PRIMARY = "character",
      ICDx = "character"
    )
  ),


  linked_hes_procedures_epi = list(
    date_cols = c("admidate", "epistart", "epiend", "discharged", "evdate"),

    col_types = c(
      patid = "character",
      spno = "integer",
      epikey = "integer",
      admidate = "character",
      epistart = "character",
      epiend = "character",
      discharged = "character",
      OPCS = "character",
      evdate = "character",
      p_order = "integer"
    )
  ),


  linked_hes_ccare = list(
    date_cols = c("admidate", "discharged", "epistart", "epiend",
                  "ccstartdate", "ccdisrdydate", "ccdisdate"),

    col_types = c(
      patid = "character",
      spno = "integer",
      epikey = "integer",
      admidate = "character",
      discharged = "character",
      epistart = "character",
      epiend = "character",
      eorder = "integer",
      ccstartdate = "character",
      ccstarttime = "character",
      ccdisrdydate = "character",
      ccdisrdytime = "character",
      ccdisdate = "character",
      ccdistime = "character",
      ccadmitype = "character",
      ccadmisorc = "integer",
      ccsorcloc = "integer",
      ccdisstat = "integer",
      ccdisdest = "integer",
      ccdisloc = "integer",
      cclev2days = "integer",
      cclev3days = "integer",
      bcardsupdays = "integer",
      acardsupdays = "integer",
      bressupdays = "integer",
      aressupdays = "integer",
      gisupdays = "integer",
      liversupdays = "integer",
      neurosupdays = "integer",
      rensupdays = "integer",
      dermsupdays = "integer",
      orgsupmax = "integer",
      ccunitfun = "integer",
      unitbedconfig = "integer",
      bestmatch = "integer",
      ccapcrel = "integer"
    )
  ),


  linked_hes_maternity = list(
    date_cols = c("epistart", "epiend", "anasdate"),

    col_types = c(
      patid = "character",
      spno = "integer",
      epikey = "integer",
      epistart = "character",
      epiend = "character",
      eorder = "integer",
      epidur = "integer",
      numbaby = "character",
      numtailb = "integer",
      matordr = "integer",
      neocare = "integer",
      wellbaby = "character",
      anasdate = "character",
      birordr = "character",
      birstat = "integer",
      biresus = "integer",
      sexbaby = "character",
      birweit = "integer",
      delmeth = "character",
      delonset = "integer",
      delinten = "integer",
      delplac = "integer",
      delchang = "integer",
      delprean = "integer",
      delposan = "integer",
      delstat = "integer",
      anagest = "integer",
      gestat = "integer",
      numpreg = "integer",
      matage = "integer",
      neodur = "integer",
      antedur = "integer",
      postdur = "integer"
    )
  ),


  linked_hes_hrg = list(
    col_types = c(
      patid = "character",
      spno = "integer",
      epikey = "integer",
      domproc = "character",
      hrglate35 = "character",
      hrgnhs = "character",
      hrgnhsvn = "character",
      suscorehrg = "character",
      sushrg = "character",
      sushrgvers = "numeric",
      hes_yr = "integer"
    )
  )
)


# HES OP (Outpatient)
.schemas_linked_hes_op <- list(

  linked_hesop_patient = list(
    col_types = c(
      patid = "character",
      pracid = "character",
      cprd_mpsid = "integer",
      gen_ethnicity = "character"
    )
  ),


  linked_hesop_patient_pathway = list(
    date_cols = c("subdate"),

    col_types = c(
      patid = "character",
      attendkey = "integer",
      subdate = "character"
    )
  ),


  linked_hesop_appointment = list(
    date_cols = c("apptdate", "dnadate", "reqdate"),

    col_types = c(
      patid = "character",
      attendkey = "integer",
      ethnos = "character",
      admincat = "integer",
      apptdate = "character",
      apptage = "integer",
      atentype = "integer",
      attended = "integer",
      dnadate = "character",
      firstatt = "character",
      outcome = "integer",
      priority = "integer",
      refsourc = "integer",
      reqdate = "character",
      servtype = "integer",
      stafftyp = "integer",
      wait_ind = "integer",
      waiting = "integer"
    )
  ),


  linked_hesop_clinical = list(
    col_types = c(
      patid = "character",
      attendkey = "integer",
      diagnosis = "character",
      icdx = "character",
      icd = "character",
      diag_order = "integer",
      tretspef = "character",
      mainspef = "character"
    )
  ),


  linked_hesop_operation = list(
    col_types = c(
      patid = "character",
      attendkey = "integer",
      operation = "character",
      opcs = "character",
      opertn_order = "integer",
      operstat = "character",
      tretspef = "character",
      mainspef = "character"
    )
  )
)


# HES A&E
.schemas_linked_hes_ae <- list(

  linked_hesae_patient = list(
    col_types = c(
      patid = "character",
      pracid = "character",
      gen_ethnicity = "character",
      cprd_mpsid = "integer",
      match_rank = "integer"
    )
  ),


  linked_hesae_attendance = list(
    date_cols = c("arrivaldate"),

    col_types = c(
      patid = "character",
      aekey = "integer",
      arrivaldate = "character",
      aepatgroup = "integer",
      aeattendcat = "integer",
      aearrivalmode = "integer",
      aedepttype = "integer",
      aerefsource = "integer",
      aeincloctype = "integer",
      aeattenddisp = "integer",
      initdur = "integer",
      tretdur = "integer",
      concldur = "integer",
      depdur = "integer",
      ethnos = "character"
    )
  ),


  linked_hesae_diagnosis = list(
    col_types = c(
      patid = "character",
      aekey = "integer",
      diag = "character",
      diag2 = "character",
      diag3 = "character",
      diaga = "character",
      diags = "character",
      diagscheme = "character",
      diag_order = "integer"
    )
  ),


  linked_hesae_investigation = list(
    col_types = c(
      patid = "character",
      aekey = "integer",
      invest = "character",
      invest2 = "character",
      invest_order = "integer"
    )
  ),


  linked_hesae_treatment = list(
    col_types = c(
      patid = "character",
      aekey = "integer",
      treat = "character",
      treat2 = "character",
      treat3 = "character",
      treat_order = "integer"
    )
  ),


  linked_hesae_hrg = list(
    col_types = c(
      patid = "character",
      aekey = "integer",
      domproc = "character",
      hrgnhs = "character",
      hrgnhsvn = "character",
      sushrg = "character",
      sushrgvers = "numeric"
    )
  ),


  linked_hesae_pathway = list(
    date_cols = c("rttperstart", "rttperend"),

    col_types = c(
      patid = "character",
      aekey = "integer",
      rttperstart = "character",
      rttperend = "character"
    )
  )
)


# HES DID
.schemas_linked_hes_did <- list(

  linked_hesdid_patient = list(
    col_types = c(
      patid = "character",
      pracid = "character",
      gen_hesid = "integer",
      n_patid_hes = "integer",
      match_rank = "integer"
    )
  ),


  linked_hesdid_referral = list(
    date_cols = c("did_date1", "did_date2"),

    col_types = c(
      patid = "character",
      submissiondataid = "integer",
      did_ethcat = "character",
      ic_reftype_desc = "character",
      ic_prov_shacode = "character",
      did_patsource_code = "integer",
      did_date1 = "character",
      did_date2 = "character",
      hes_did_matchrank = "character"
    )
  ),


  linked_hesdid_test = list(
    date_cols = c("did_date3", "did_date4"),

    col_types = c(
      patid = "character",
      submissiondataid = "integer",
      fyear = "integer",
      did_date3 = "character",
      did_date4 = "character",
      did_nicip_code = "character",
      did_snomedct_code = "integer",
      ic_modality_id = "integer",
      ic_sub_modality_id = "integer",
      ic_region_id = "integer",
      ic_sub_region_id = "integer",
      ic_system_id = "integer",
      ic_sub_sys_id = "integer",
      ic_sub_syscomp_id = "integer",
      ic_morhpology_id = "integer",
      ic_fetal_id = "integer",
      ic_cancer_desc = "character",
      ic_sub_cancer_desc = "character"
    )
  )
)


# ONS Deaths
.schemas_linked_deaths <- list(

  linked_deaths_patient = list(
    date_cols = c("reg_date", "reg_date_of_death"),

    col_types = c(
      patid = "character",
      pracid = "integer",
      reg_date = "character",
      reg_date_of_death = "character",
      pod_nhs_establishment = "integer",
      pod_code = "character",
      pod_establishment_type = "character",
      icd9_orig_mention_1 = "character",
      icd9_orig_mention_2 = "character",
      icd9_orig_mention_3 = "character",
      icd9_orig_mention_4 = "character",
      icd9_orig_mention_5 = "character",
      icd9_orig_mention_6 = "character",
      icd9_orig_mention_7 = "character",
      icd9_orig_mention_8 = "character",
      icd9_orig_mention_9 = "character",
      icd9_orig_mention_10 = "character",
      icd9_orig_mention_11 = "character",
      icd9_orig_mention_12 = "character",
      icd9_orig_mention_13 = "character",
      icd9_orig_mention_14 = "character",
      icd9_orig_mention_15 = "character",
      s_cod_code_1 = "character",
      s_cod_code_2 = "character",
      s_cod_code_3 = "character",
      s_cod_code_4 = "character",
      s_cod_code_5 = "character",
      s_cod_code_6 = "character",
      s_cod_code_7 = "character",
      s_cod_code_8 = "character",
      s_cod_code_9 = "character",
      s_cod_code_10 = "character",
      s_cod_code_11 = "character",
      s_cod_code_12 = "character",
      s_cod_code_13 = "character",
      s_cod_code_14 = "character",
      s_cod_code_15 = "character",
      neo_nate_flag = "character",
      s_underlying_cod_icd10 = "character",
      s_underlying_cod_icd9 = "character"
    )
  )
)


# Small area data
.schemas_linked_smallarea <- list(

  linked_practice_imd = list(
    col_types = c(
      pracid = "character",
      country = "integer",
      e_imd_5 = "integer",
      e_imd_10 = "integer",
      ni_imd_5 = "integer",
      ni_imd_10 = "integer",
      s_imd_5 = "integer",
      s_imd_10 = "integer",
      w_imd_5 = "integer",
      w_imd_10 = "integer"
    )
  ),


  linked_imd_domains = list(
    col_types = c(
      pracid = "character",
      country = "integer",
      e_income_5 = "integer",
      e_income_10 = "integer",
      e_employment_5 = "integer",
      e_employment_10 = "integer",
      e_education_5 = "integer",
      e_education_10 = "integer",
      e_health_5 = "integer",
      e_health_10 = "integer",
      e_crime_5 = "integer",
      e_crime_10 = "integer",
      e_access_5 = "integer",
      e_access_10 = "integer",
      e_environment_5 = "integer",
      e_environment_10 = "integer",
      e_housing_5 = "integer",
      e_housing_10 = "integer",
      e_outdoor_environment_5 = "integer",
      e_outdoor_environment_10 = "integer",
      ni_income_5 = "integer",
      ni_income_10 = "integer",
      ni_employment_5 = "integer",
      ni_employment_10 = "integer",
      ni_education_5 = "integer",
      ni_education_10 = "integer",
      ni_health_5 = "integer",
      ni_health_10 = "integer",
      ni_crime_5 = "integer",
      ni_crime_10 = "integer",
      ni_access_5 = "integer",
      ni_access_10 = "integer",
      ni_environment_5 = "integer",
      ni_environment_10 = "integer",
      ni_housing_5 = "integer",
      ni_housing_10 = "integer",
      ni_outdoor_environment_5 = "integer",
      ni_outdoor_environment_10 = "integer",
      s_income_5 = "integer",
      s_income_10 = "integer",
      s_employment_5 = "integer",
      s_employment_10 = "integer",
      s_education_5 = "integer",
      s_education_10 = "integer",
      s_health_5 = "integer",
      s_health_10 = "integer",
      s_crime_5 = "integer",
      s_crime_10 = "integer",
      s_access_5 = "integer",
      s_access_10 = "integer",
      s_housing_5 = "integer",
      s_housing_10 = "integer",
      w_income_5 = "integer",
      w_income_10 = "integer",
      w_employment_5 = "integer",
      w_employment_10 = "integer",
      w_education_5 = "integer",
      w_education_10 = "integer",
      w_health_5 = "integer",
      w_health_10 = "integer",
      w_crime_5 = "integer",
      w_crime_10 = "integer",
      w_access_5 = "integer",
      w_access_10 = "integer",
      w_housing_5 = "integer",
      w_housing_10 = "integer",
      w_outdoor_environment_5 = "integer",
      w_outdoor_environment_10 = "integer"
    )
  ),


  linked_practice_townsend2011 = list(
    col_types = c(
      pracid = "character",
      uk_townsend_5 = "integer",
      uk_townsend_10 = "integer"
    )
  ),


  linked_practice_carstairs = list(
    col_types = c(
      pracid = "character",
      gb_carstairs_5 = "integer",
      gb_carstairs_10 = "integer"
    )
  ),


  linked_practice_urbanrural = list(
    col_types = c(
      pracid = "character",
      e_urban_rural = "integer",
      w_urban_rural = "integer",
      s_urban_rural = "integer",
      ni_urban_rural = "integer"
    )
  ),


  linked_practice_subicbloc = list(
    col_types = c(
      pracid = "character",
      subicbloc = "integer"
    )
  ),


  linked_practice_coastal = list(
    col_types = c(
      pracid = "character",
      e_coastal = "integer"
    )
  )
)

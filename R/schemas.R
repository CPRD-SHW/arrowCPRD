#' Schemas for reading in Aurum data by types
#'
#' @param dataset_name Name of dataset - "aurum" or "gold"
#' @param table_name Name of table - "observation" etc.
#'
#' @returns A "schema" - a list of names of variables, r data types and arrow types
#'
#' @export
#' @examples
#' get_schema("aurum", "observation")
#' get_schema("aurum", "patient")
#'
get_schema <- function(dataset_name = NULL,
                       table_name = NULL) {
  if (is.null(dataset_name) || is.null(table_name)) {
    message(
      "Please use one of the following pairs of dataset/table names for a schema:\n - ",
      paste(gsub("_", " / ", x = names(.schemas)), collapse = "\n - ")
    )

    return(invisible())

  }

  key <- paste(dataset_name, table_name, sep = "_")

  schema <- .schemas[[key]]

  if (is.null(schema)) {
    stop(sprintf("No schema found for '%s_%s'", dataset_name, table_name),
         call. = FALSE)
  }

  schema$arrow_schema <- eval(schema$arrow_schema)

  schema

}

.schemas <- list(
  aurum_observation = list(
    names = c(
      "patid",
      "consid",
      "pracid",
      "obsid",
      "obsdate",
      "enterdate",
      "staffid",
      "parentobsid",
      "medcodeid",
      "value",
      "numunitid",
      "obstypeid",
      "numrangelow",
      "numrangehigh",
      "probobsid"
    ),

    read_in_types = c(
      "character",
      "character",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "character",
      "character",
      "numeric",
      "integer",
      "integer",
      "numeric",
      "numeric",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        consid = arrow::utf8(),
        pracid = arrow::int64(),
        obsid = arrow::utf8(),
        obsdate = arrow::utf8(),
        enterdate = arrow::utf8(),
        staffid = arrow::utf8(),
        parentobsid = arrow::utf8(),
        medcodeid = arrow::utf8(),
        value = arrow::float64(),
        numunitid = arrow::int64(),
        obstypeid = arrow::int64(),
        numrangelow = arrow::float64(),
        numrangehigh = arrow::float64(),
        probobsid = arrow::utf8()
      )
    )

  ),


  aurum_linkage = list(
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
      "integer",
      "integer"
    )

  ),


  aurum_patient = list(
    names = c(
      "patid",
      "pracid",
      "usualgpstaffid",
      "gender",
      "yob",
      "mob",
      "emis_ddate",
      "regstartdate",
      "patienttypeid",
      "regenddate",
      "acceptable",
      "cprd_ddate"
    ),

    read_in_types = c(
      "character",
      "integer",
      "character",
      "integer",
      "integer",
      "integer",
      "character",
      "character",
      "integer",
      "character",
      "integer",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        pracid = arrow::int64(),
        usualgpstaffid = arrow::utf8(),
        gender = arrow::int64(),
        yob = arrow::int64(),
        mob = arrow::int64(),
        emis_ddate = arrow::utf8(),
        regstartdate = arrow::utf8(),
        patienttypeid = arrow::int64(),
        regenddate = arrow::utf8(),
        acceptable = arrow::int64(),
        cprd_ddate = arrow::utf8()
      )
    )
  ),


  aurum_practice = list(
    names = c("pracid", "lcd", "uts", "region"),
    read_in_types = c("integer", "character", "character", "integer"),
    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::int64(),
        lcd = arrow::utf8(),
        uts = arrow::utf8(),
        region = arrow::int64()
      )
    )

  ),


  aurum_problem = list(
    names = c(
      "patid",
      "obsid",
      "pracid",
      "parentprobobsid",
      "probenddate",
      "expduration",
      "lastrevdate",
      "lastrevstaffid",
      "parentprobrelid",
      "probstatusid",
      "signid"
    ),

    read_in_types = c(
      "character",
      "character",
      "integer",
      "character",
      "character",
      "integer",
      "character",
      "character",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        obsid = arrow::utf8(),
        pracid = arrow::int64(),
        parentprobobsid = arrow::utf8(),
        probenddate = arrow::utf8(),
        expduration = arrow::int64(),
        lastrevdate = arrow::utf8(),
        lastrevstaffid = arrow::utf8(),
        parentprobrelid = arrow::int64(),
        probstatusid = arrow::int64(),
        signid = arrow::int64()
      )
    )
  ),



  aurum_referral = list(
    names = c(
      "patid",
      "obsid",
      "pracid",
      "refsourceorgid",
      "reftargetorgid",
      "refurgencyid",
      "refservicetypeid",
      "refmodeid"
    ),

    read_in_types = c(
      "character",
      "character",
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
        obsid = arrow::utf8(),
        pracid = arrow::int64(),
        refsourceorgid = arrow::int64(),
        reftargetorgid = arrow::int64(),
        refurgencyid = arrow::int64(),
        refservicetypeid = arrow::int64(),
        refmodeid = arrow::int64()
      )
    )
  ),


  aurum_drug = list(
    names = c(
      "patid",
      "issueid",
      "pracid",
      "probobsid",
      "drugrecid",
      "issuedate",
      "enterdate",
      "staffid",
      "prodcodeid",
      "dosageid",
      "quantity",
      "quantunitid",
      "duration",
      "estnhscost"
    ),

    read_in_types = c(
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
      "numeric",
      "integer",
      "integer",
      "numeric"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        issueid = arrow::utf8(),
        pracid = arrow::int64(),
        probobsid = arrow::utf8(),
        drugrecid = arrow::utf8(),
        issuedate = arrow::utf8(),
        enterdate = arrow::utf8(),
        staffid = arrow::utf8(),
        prodcodeid = arrow::utf8(),
        dosageid = arrow::utf8(),
        quantity = arrow::float64(),
        quantunitid = arrow::int64(),
        duration = arrow::int64(),
        estnhscost = arrow::float64()
      )
    )
  ),


  aurum_consultation = list(
    names = c(
      "patid",
      "consid",
      "pracid",
      "consdate",
      "enterdate",
      "staffid",
      "conssourceid",
      "cprdconstype",
      "consmedcodeid"
    ),

    read_in_types = c(
      "character",
      "character",
      "integer",
      "character",
      "character",
      "character",
      "character",
      "integer",
      "character"
    ),

    arrow_schema = quote(
      arrow::schema(
        patid = arrow::utf8(),
        consid = arrow::utf8(),
        pracid = arrow::int64(),
        consdate = arrow::utf8(),
        enterdate = arrow::utf8(),
        staffid = arrow::utf8(),
        conssourceid = arrow::utf8(),
        cprdconstype = arrow::int64(),
        consmedcodeid = arrow::utf8()
      )
    )
  ),


  aurum_staff = list(
    names = c("staffid", "pracid", "jobcatid"),

    read_in_types = c("character", "character", "character"),

    arrow_schema = quote(
      arrow::schema(
        staffid = arrow::utf8(),
        pracid = arrow::utf8(),
        jobcatid = arrow::utf8()
      )
    )
  ),


  gold_patient = list(
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
        sctisindicative = arrow::int64(),
        sctisassured = arrow::int64(),
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
        sctisindicative = arrow::int64(),
        sctisassured = arrow::int64(),
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
        sctisindicative = arrow::int64(),
        sctisassured = arrow::int64(),
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
      "integer",
      "integer",
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
        sctisindicative = arrow::int64(),
        sctisassured = arrow::int64(),
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

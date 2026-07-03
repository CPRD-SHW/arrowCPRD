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
  )

)

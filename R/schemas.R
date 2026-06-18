#' Schemas for reading in Aurum data by types
#' @name aurum_schemas
aurum_observation_schemas <- list(
  names <- c(
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
    'character',
    'character',
    'integer',
    'character',
    'character',
    'character',
    'character',
    'character',
    'character',
    'numeric',
    'integer',
    'integer',
    'numeric',
    'numeric',
    'character'
  )


)

#' @rdname aurum_schemas
aurum_linkage_schemas <- list(
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

)

#' @rdname aurum_schemas
aurum_patient_schemas <- list(
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
  )
)

#' @rdname aurum_schemas
aurum_practice_schemas <- list(
  names = c("pracid", "lcd", "uts", "region"),
  read_in_types = c("integer", "character", "character", "integer")

)

#' @rdname aurum_schemas
aurum_problem_schemas <- list(
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
  )
)


#' @rdname aurum_schemas
aurum_referral_schemas <- list(
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
  )
)

#' @rdname aurum_schemas
aurum_drug_schemas <- list(
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
  )
)

#' @rdname aurum_schemas
aurum_consultation_schemas <- list(
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
  )

)

#' @rdname aurum_schemas
aurum_staff_schemas <- list(
  names = c("staffid", "pracid", "jobcatid"),

  read_in_types = c("character", "character", "character")
)

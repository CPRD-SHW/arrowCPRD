# =================== Generate synthetic Aurum/GOLD extracts ===================

# Constants ====================================================================

SYNTH_PRACID_CHARS <- 5L

SYNTH_CACHE_DIR <- "synthetic"

# The key columns a child table inherits from its parent consultation.
SYNTH_CONS_KEYS <- c("patid", "pracid", "consid", "staffid")

SYNTH_RATIOS <- list(
  aurum = list(
    patients_per_practice         = 10L,
    staff_per_practice            = 3L,
    consultations_per_patient     = 4L,
    observations_per_consultation = 3L,
    drugs_per_consultation        = 2L,
    problems_per_patient          = 1L,
    referrals_per_patient         = 1L
  ),

  gold = list(
    patients_per_practice     = 10L,
    staff_per_practice        = 3L,
    consultations_per_patient = 4L,
    clinical_per_consultation = 3L,
    therapy_per_consultation  = 2L,
    tests_per_consultation    = 1L,
    referrals_per_patient     = 1L,
    immunisations_per_patient = 1L,
    additional_per_patient    = 1L
  )
)

# Schema keys whose delivery filename tag differs from the table name.
SYNTH_FILE_TAGS <- list(
  aurum_drug = "drugissue"
)

# Helpers ======================================================================

# Draw one element from `x` without `sample()`'s length-1-numeric issue
synth_sample_one <- function(x) x[sample.int(length(x), 1L)]

# A digit-only id string of exactly `width` characters
synth_digit_id <- function(seq, width) {
  lead <- (seq %% 9L) + 1L
  tail <- seq %% (10 ^ (width - 1L))
  sprintf(paste0("%d%0", width - 1L, "d"), lead, tail)
}

# Practice ids, drawn from the SYNTH_PRACID_CHARS-digit range.
synth_pracid_pool <- function(n_practices) {
  lower <- 10 ^ (SYNTH_PRACID_CHARS - 1L)
  upper <- 10 ^ SYNTH_PRACID_CHARS - 1L

  sample(lower:upper, n_practices)
}

# The practice each staff member and each patient belongs to
synth_practice_layout <- function(n_patients, ratios) {
  n_practices <- ceiling(n_patients / ratios$patients_per_practice)
  pracid <- synth_pracid_pool(n_practices)

  list(
    pracid         = pracid,
    staff_pracid   = rep(pracid, each = ratios$staff_per_practice),
    patient_pracid = rep(pracid, length.out = n_patients)
  )
}

# One staff member's id per element of `pracid_vec`, drawn from staff
# already assigned to that practice.
synth_pick_staff <- function(staff, pracid_vec, id_type) {
  vapply(pracid_vec, \(pr) {
    synth_sample_one(staff$staffid[staff$pracid == pr])
  }, id_type)
}

synth_rep_each <- function(n, times) rep(seq_len(n), each = times)

# `times` child rows per row of `parent`, inheriting `cols` from it.
synth_child_rows <- function(parent, times, cols = SYNTH_CONS_KEYS) {
  rows <- parent[synth_rep_each(nrow(parent), times), cols, drop = FALSE]
  rownames(rows) <- NULL

  rows
}

# `times` child rows per patient, hung off that patient's first `parent` row.
synth_child_rows_per_patient <- function(patient, parent, times,
                                         cols = SYNTH_CONS_KEYS) {
  first <- parent[match(patient$patid, parent$patid), , drop = FALSE]

  synth_child_rows(first, times, cols)
}

# The first `times` rows of each patient's block, used where a table is built
# from a subset of another table's rows rather than from fresh ids. Relies on
# rows already being contiguous per patient.
synth_first_per_patient <- function(df, times, cols = names(df)) {
  rank <- ave(seq_len(nrow(df)), df$patid, FUN = seq_along)
  rows <- df[rank <= times, cols, drop = FALSE]
  rownames(rows) <- NULL

  rows
}

# A uniform random date
synth_date_column <- function(n, date_format) {
  start <- as.Date("1990-01-01")
  span  <- as.integer(as.Date("2020-12-31") - start)

  format(start + sample.int(span + 1L, n, replace = TRUE) - 1L, date_format)
}

# Generic fill for a column with no FK meaning
synth_generic_column <- function(name, type, n) {
  is_code <- grepl("id$", name) || name %in% c("sctid", "sctdescid", "drugdmd")

  if (type == "character" && is_code) {
    synth_digit_id(sample.int(1e8, n), width = sample(10:18, 1L))
  } else if (type == "character") {
    sample(c("aa", "bb", "cc", "dd", "ee"), n, replace = TRUE)
  } else if (type == "integer") {
    sample(1:100, n, replace = TRUE)
  } else {
    round(runif(n, 0, 1000), 2)
  }
}

# Blank out a fixed 10% of each nullable date column, written as ""
synth_apply_missingness <- function(df, date_cols, rate = 0.1) {
  for (col in date_cols) {
    n_missing <- floor(nrow(df) * rate)
    if (n_missing == 0L) next

    idx <- sample.int(nrow(df), n_missing)
    df[[col]][idx] <- ""
  }

  df
}

# Complete a pool data frame (which already carries the FK columns) into a
# full table.
synth_finalise_table <- function(pool_df, dataset, table, date_format) {
  schema <- get_schema(dataset, table)
  n <- nrow(pool_df)

  for (col in schema$names) {
    if (col %in% names(pool_df)) next

    if (col %in% schema$date_cols) {
      pool_df[[col]] <- synth_date_column(n, date_format)
    } else {
      type <- schema$read_in_types[schema$names == col]
      pool_df[[col]] <- synth_generic_column(col, type, n)
    }
  }

  pool_df <- synth_apply_missingness(pool_df, schema$date_cols)

  pool_df[, schema$names, drop = FALSE]
}

# Key pools -- Aurum ===========================================================

synth_key_pools_aurum <- function(n_patients, ratios) {
  layout <- synth_practice_layout(n_patients, ratios)

  practice <- data.frame(pracid = layout$pracid)

  staff <- data.frame(
    staffid = synth_digit_id(seq_along(layout$staff_pracid), 10L),
    pracid  = layout$staff_pracid
  )

  patient <- data.frame(
    patid          = synth_digit_id(seq_len(n_patients), 18L),
    pracid         = layout$patient_pracid,
    usualgpstaffid = synth_pick_staff(
      staff, layout$patient_pracid, character(1)
    )
  )

  consultation <- synth_child_rows(
    patient, ratios$consultations_per_patient, cols = c("patid", "pracid")
  )
  consultation$consid <- synth_digit_id(seq_len(nrow(consultation)), 12L)
  consultation$staffid <- synth_pick_staff(
    staff, consultation$pracid, character(1)
  )

  observation <- synth_child_rows(
    consultation, ratios$observations_per_consultation
  )
  observation$obsid <- synth_digit_id(seq_len(nrow(observation)), 14L)

  # Each observation's parent is the previous observation for the same
  # patient (blank for a patient's first)
  observation$parentobsid <- ave(
    observation$obsid, observation$patid,
    FUN = \(x) c("", x[-length(x)])
  )
  observation$probobsid <- ""

  picked <- synth_first_per_patient(observation, ratios$problems_per_patient)

  problem <- data.frame(
    obsid           = picked$obsid,
    patid           = picked$patid,
    pracid          = picked$pracid,
    parentprobobsid = ave(
      picked$obsid, picked$patid, FUN = \(x) c("", x[-length(x)])
    ),
    lastrevstaffid  = synth_pick_staff(staff, picked$pracid, character(1))
  )

  # Cycle: observation.probobsid -> problem.obsid -> observation.obsid.
  # Backfill one observation per patient that has a problem; `match()` finds
  # that patient's first observation row.
  problem_first <- problem[!duplicated(problem$patid), c("patid", "obsid")]
  observation$probobsid[match(problem_first$patid, observation$patid)] <-
    problem_first$obsid

  drug <- synth_child_rows(consultation, ratios$drugs_per_consultation)
  drug$issueid <- synth_digit_id(seq_len(nrow(drug)), 14L)
  drug$probobsid <- problem_first$obsid[match(drug$patid, problem_first$patid)]
  drug$probobsid[is.na(drug$probobsid)] <- ""

  referral <- synth_child_rows_per_patient(
    patient, observation, ratios$referrals_per_patient,
    cols = c("obsid", "patid", "pracid")
  )

  list(
    practice     = practice,
    staff        = staff,
    patient      = patient,
    consultation = consultation,
    observation  = observation,
    problem      = problem,
    drug         = drug,
    referral     = referral
  )
}

# Key pools -- GOLD ============================================================

synth_key_pools_gold <- function(n_patients, ratios) {
  layout <- synth_practice_layout(n_patients, ratios)

  practice <- data.frame(pracid = layout$pracid)

  # Neither gold_patient nor gold_staff carries a `pracid` column, so the
  # practice link is positional: the last SYNTH_PRACID_CHARS digits of the
  # id.
  staff <- data.frame(
    staffid = as.integer(
      paste0(seq_along(layout$staff_pracid), layout$staff_pracid)
    ),
    pracid  = layout$staff_pracid
  )

  patient <- data.frame(
    patid  = sprintf("%d%d", seq_len(n_patients), layout$patient_pracid),
    pracid = layout$patient_pracid
  )

  consultation <- synth_child_rows(
    patient, ratios$consultations_per_patient, cols = c("patid", "pracid")
  )
  consultation$consid <- seq_len(nrow(consultation))
  consultation$staffid <- synth_pick_staff(
    staff, consultation$pracid, integer(1)
  )

  clinical <- synth_child_rows(consultation, ratios$clinical_per_consultation)
  clinical$enttype <- 1L
  clinical$adid <- seq_len(nrow(clinical))

  additional <- synth_first_per_patient(
    clinical, ratios$additional_per_patient,
    cols = c("patid", "enttype", "adid")
  )

  referral <- synth_child_rows_per_patient(
    patient, consultation, ratios$referrals_per_patient
  )

  immunisation <- synth_child_rows_per_patient(
    patient, consultation, ratios$immunisations_per_patient
  )

  therapy <- synth_child_rows(consultation, ratios$therapy_per_consultation)

  test <- synth_child_rows(consultation, ratios$tests_per_consultation)

  list(
    practice     = practice,
    staff        = staff,
    patient      = patient,
    consultation = consultation,
    clinical     = clinical,
    additional   = additional,
    referral     = referral,
    immunisation = immunisation,
    therapy      = therapy,
    test         = test
  )
}

synth_key_pools <- function(dataset, n_patients, ratios) {
  switch(
    dataset,
    aurum = synth_key_pools_aurum(n_patients, ratios),
    gold  = synth_key_pools_gold(n_patients, ratios)
  )
}

# Table builders ===============================================================

synth_build_tables <- function(dataset, pools, date_format) {
  Map(
    \(pool_df, table) {
      synth_finalise_table(pool_df, dataset, table, date_format)
    },
    pools,
    names(pools)
  )
}

# Writing ======================================================================

# Split `df`'s rows into up to `n_files` roughly-equal chunks (fewer if
# `df` has fewer rows than `n_files`), one group id per row.
synth_file_groups <- function(n, n_files) {
  rows_per_file <- ceiling(n / n_files)
  ceiling(seq_len(n) / rows_per_file)
}

synth_write_extract <- function(tables, extract_dir, dataset, n_files) {
  txt_dir <- file.path(extract_dir, "txt")
  zip_dir <- file.path(extract_dir, "zip")

  unlink(c(txt_dir, zip_dir), recursive = TRUE)

  dir.create(txt_dir, recursive = TRUE, showWarnings = FALSE)
  dir.create(zip_dir, recursive = TRUE, showWarnings = FALSE)

  txt_paths <- character(0)

  for (table_name in names(tables)) {
    df  <- tables[[table_name]]
    tag <- SYNTH_FILE_TAGS[[paste(dataset, table_name, sep = "_")]]
    if (is.null(tag)) tag <- table_name

    part <- synth_file_groups(nrow(df), n_files)

    for (part_n in seq_len(n_files)) {
      part_rows <- df[part == part_n, , drop = FALSE]
      if (nrow(part_rows) == 0L) next

      filename <- sprintf(
        "%s_allpatid_set1_extract_%s_%03d.txt", dataset, tag, part_n
      )
      filepath <- file.path(txt_dir, filename)

      write.table(
        part_rows, filepath,
        sep = "\t", quote = FALSE, row.names = FALSE, na = ""
      )

      txt_paths <- c(txt_paths, filepath)
    }
  }

  # Every table of a dataset is delivered in one archive, so a test pointing
  # the zipped route at `zip_dir` sees the whole extract in a single zip.
  zip_path <- file.path(zip_dir, sprintf("%s.zip", dataset))
  zip::zip(zip_path, txt_paths, mode = "cherry-pick")

  invisible(NULL)
}

# Caching ======================================================================

synth_cache_root <- function() {
  testthat::test_path(SYNTH_CACHE_DIR)
}

# TRUE when both halves of an extract are already on disk
synth_cache_exists <- function(extract_dir) {
  dir.exists(file.path(extract_dir, "txt")) &&
    dir.exists(file.path(extract_dir, "zip"))
}

# Entry point ==================================================================

# Generate a synthetic extract, or reuse the one already on disk.
make_synthetic_extract <- function(dataset = c("aurum", "gold"),
                                   n_patients = 20L,
                                   out_dir = NULL,
                                   name = NULL,
                                   ratios = NULL,
                                   n_files = 2L,
                                   date_format = "%d/%m/%Y",
                                   seed = 1L,
                                   force = FALSE) {
  dataset <- match.arg(dataset)

  if (is.null(out_dir)) out_dir <- synth_cache_root()
  if (is.null(name)) name <- dataset
  if (is.null(ratios)) ratios <- SYNTH_RATIOS[[dataset]]

  extract_dir <- file.path(out_dir, name)

  tables <- withr::with_seed(seed, {
    pools <- synth_key_pools(dataset, n_patients, ratios)
    synth_build_tables(dataset, pools, date_format)
  })

  if (force || !synth_cache_exists(extract_dir)) {
    dir.create(extract_dir, recursive = TRUE, showWarnings = FALSE)
    synth_write_extract(tables, extract_dir, dataset, n_files)
  }

  zip_dir <- file.path(extract_dir, "zip")

  list(
    extract_dir = extract_dir,
    txt_dir     = file.path(extract_dir, "txt"),
    zip_dir     = zip_dir,
    zip_paths   = list.files(zip_dir, pattern = "\\.zip$", full.names = TRUE),
    tables      = tables
  )
}

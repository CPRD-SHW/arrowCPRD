# Linked data table schemas
.schemas_linked <- list(

  ## Small area
  linked_practice_imd = list(
    names = c(
      "pracid",
      "country",
      "e_imd_5",
      "e_imd_10",
      "ni_imd_5",
      "ni_imd_10",
      "s_imd_5",
      "s_imd_10",
      "w_imd_5",
      "w_imd_10"
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
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::utf8(),
        country = arrow::int64(),
        e_imd_5 = arrow::int64(),
        e_imd_10 = arrow::int64(),
        ni_imd_5 = arrow::int64(),
        ni_imd_10 = arrow::int64(),
        s_imd_5 = arrow::int64(),
        s_imd_10 = arrow::int64(),
        w_imd_5 = arrow::int64(),
        w_imd_10 = arrow::int64()
      )
    )
  ),


  linked_imd_domains = list(
    names = c(
      "pracid",
      "country",
      "e_income_5",
      "e_income_10",
      "e_employment_5",
      "e_employment_10",
      "e_education_5",
      "e_education_10",
      "e_health_5",
      "e_health_10",
      "e_crime_5",
      "e_crime_10",
      "e_access_5",
      "e_access_10",
      "e_environment_5",
      "e_environment_10",
      "e_housing_5",
      "e_housing_10",
      "e_outdoor_environment_5",
      "e_outdoor_environment_10",
      "ni_income_5",
      "ni_income_10",
      "ni_employment_5",
      "ni_employment_10",
      "ni_education_5",
      "ni_education_10",
      "ni_health_5",
      "ni_health_10",
      "ni_crime_5",
      "ni_crime_10",
      "ni_access_5",
      "ni_access_10",
      "ni_environment_5",
      "ni_environment_10",
      "ni_housing_5",
      "ni_housing_10",
      "ni_outdoor_environment_5",
      "ni_outdoor_environment_10",
      "s_income_5",
      "s_income_10",
      "s_employment_5",
      "s_employment_10",
      "s_education_5",
      "s_education_10",
      "s_health_5",
      "s_health_10",
      "s_crime_5",
      "s_crime_10",
      "s_access_5",
      "s_access_10",
      "s_housing_5",
      "s_housing_10",
      "w_income_5",
      "w_income_10",
      "w_employment_5",
      "w_employment_10",
      "w_education_5",
      "w_education_10",
      "w_health_5",
      "w_health_10",
      "w_crime_5",
      "w_crime_10",
      "w_access_5",
      "w_access_10",
      "w_housing_5",
      "w_housing_10",
      "w_outdoor_environment_5",
      "w_outdoor_environment_10"
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
        pracid = arrow::utf8(),
        country = arrow::int64(),
        e_income_5 = arrow::int64(),
        e_income_10 = arrow::int64(),
        e_employment_5 = arrow::int64(),
        e_employment_10 = arrow::int64(),
        e_education_5 = arrow::int64(),
        e_education_10 = arrow::int64(),
        e_health_5 = arrow::int64(),
        e_health_10 = arrow::int64(),
        e_crime_5 = arrow::int64(),
        e_crime_10 = arrow::int64(),
        e_access_5 = arrow::int64(),
        e_access_10 = arrow::int64(),
        e_environment_5 = arrow::int64(),
        e_environment_10 = arrow::int64(),
        e_housing_5 = arrow::int64(),
        e_housing_10 = arrow::int64(),
        e_outdoor_environment_5 = arrow::int64(),
        e_outdoor_environment_10 = arrow::int64(),
        ni_income_5 = arrow::int64(),
        ni_income_10 = arrow::int64(),
        ni_employment_5 = arrow::int64(),
        ni_employment_10 = arrow::int64(),
        ni_education_5 = arrow::int64(),
        ni_education_10 = arrow::int64(),
        ni_health_5 = arrow::int64(),
        ni_health_10 = arrow::int64(),
        ni_crime_5 = arrow::int64(),
        ni_crime_10 = arrow::int64(),
        ni_access_5 = arrow::int64(),
        ni_access_10 = arrow::int64(),
        ni_environment_5 = arrow::int64(),
        ni_environment_10 = arrow::int64(),
        ni_housing_5 = arrow::int64(),
        ni_housing_10 = arrow::int64(),
        ni_outdoor_environment_5 = arrow::int64(),
        ni_outdoor_environment_10 = arrow::int64(),
        s_income_5 = arrow::int64(),
        s_income_10 = arrow::int64(),
        s_employment_5 = arrow::int64(),
        s_employment_10 = arrow::int64(),
        s_education_5 = arrow::int64(),
        s_education_10 = arrow::int64(),
        s_health_5 = arrow::int64(),
        s_health_10 = arrow::int64(),
        s_crime_5 = arrow::int64(),
        s_crime_10 = arrow::int64(),
        s_access_5 = arrow::int64(),
        s_access_10 = arrow::int64(),
        s_housing_5 = arrow::int64(),
        s_housing_10 = arrow::int64(),
        w_income_5 = arrow::int64(),
        w_income_10 = arrow::int64(),
        w_employment_5 = arrow::int64(),
        w_employment_10 = arrow::int64(),
        w_education_5 = arrow::int64(),
        w_education_10 = arrow::int64(),
        w_health_5 = arrow::int64(),
        w_health_10 = arrow::int64(),
        w_crime_5 = arrow::int64(),
        w_crime_10 = arrow::int64(),
        w_access_5 = arrow::int64(),
        w_access_10 = arrow::int64(),
        w_housing_5 = arrow::int64(),
        w_housing_10 = arrow::int64(),
        w_outdoor_environment_5 = arrow::int64(),
        w_outdoor_environment_10 = arrow::int64()
      )
    )
  ),


  linked_practice_townsend2011 = list(
    names = c(
      "pracid",
      "uk_townsend_5",
      "uk_townsend_10"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::utf8(),
        uk_townsend_5 = arrow::int64(),
        uk_townsend_10 = arrow::int64()
      )
    )
  ),


  linked_practice_carstairs = list(
    names = c(
      "pracid",
      "gb_carstairs_5",
      "gb_carstairs_10"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::utf8(),
        gb_carstairs_5 = arrow::int64(),
        gb_carstairs_10 = arrow::int64()
      )
    )
  ),


  linked_practice_urbanrural = list(
    names = c(
      "pracid",
      "e_urban_rural",
      "w_urban_rural",
      "s_urban_rural",
      "ni_urban_rural"
    ),

    read_in_types = c(
      "character",
      "integer",
      "integer",
      "integer",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::utf8(),
        e_urban_rural = arrow::int64(),
        w_urban_rural = arrow::int64(),
        s_urban_rural = arrow::int64(),
        ni_urban_rural = arrow::int64()
      )
    )
  ),


  linked_practice_subicbloc = list(
    names = c(
      "pracid",
      "subicbloc"
    ),

    read_in_types = c(
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::utf8(),
        subicbloc = arrow::int64()
      )
    )
  ),


  linked_practice_coastal = list(
    names = c(
      "pracid",
      "e_coastal"
    ),

    read_in_types = c(
      "character",
      "integer"
    ),

    arrow_schema = quote(
      arrow::schema(
        pracid = arrow::utf8(),
        e_coastal = arrow::int64()
      )
    )
  )
)


SELECT
  all_staff_report.research_id,
  all_staff_report.school_year as year_session,
  TRIM(lower(all_staff_report.first_name)) as first_name,
  TRIM(lower(all_staff_report.last_name)) as last_name,
  SAFE_CAST(all_staff_report.entity_id as STRING) as entity_id,
  TRIM(all_staff_report.gender) as gender,
  TRIM(SPLIT(all_staff_report.raceethnicity, " - ")[safe_offset(0)]) as race_ethnicity_cd,
  TRIM(SPLIT(all_staff_report.raceethnicity, " - ")[safe_offset(1)]) as race_ethnicity_desc,
  all_staff_report.birth_year,
  TRIM(SPLIT(all_staff_report.contract_hire_agency," - ")[safe_offset(0)]) as contract_hire_agency_cd,
  TRIM(SPLIT(all_staff_report.contract_hire_agency," - ")[safe_offset(1)]) as contract_hire_agency_desc,
  TRIM(SPLIT(all_staff_report.contract_high_degree, " - ")[safe_offset(0)]) as contract_high_degree_cd,
  TRIM(SPLIT(all_staff_report.contract_high_degree, " - ")[safe_offset(1)]) as contract_high_degree_desc,
  SAFE_CAST(all_staff_report.contract_days as INT64) as contract_days,
  all_staff_report.contract_local_experience,
  all_staff_report.contract_total_experience,
  CAST(REGEXP_REPLACE(REGEXP_REPLACE(all_staff_report.total_salary, r"^[$]",""), r",","") AS FLOAT64) as salary,
  CAST(REGEXP_REPLACE(REGEXP_REPLACE(all_staff_report.total_fringe, r"^[$]",""), r",","") AS FLOAT64) as benefits,
  TRIM(SPLIT(all_staff_report.assignment_area, " - ")[safe_offset(0)]) as assignment_area_cd,
  TRIM(SPLIT(all_staff_report.assignment_area, " - ")[safe_offset(1)]) as assignment_area_desc,
  TRIM(SPLIT(all_staff_report.assignment_staff_category, " - ")[safe_offset(0)]) as assignment_staff_category_cd,
  TRIM(SPLIT(all_staff_report.assignment_staff_category, " - ")[safe_offset(1)]) as assignment_staff_category_desc,
  all_staff_report.position_classification,
  TRIM(SPLIT(all_staff_report.hire_agency, " - ")[safe_offset(0)]) as hire_agency_cd,
  hire_agency_districts.district_name as hire_agency_desc,
  TRIM(SPLIT(all_staff_report.assignment_hire_agency_type, " - ")[safe_offset(0)]) as assignment_hire_agency_type_cd,
  TRIM(SPLIT(all_staff_report.assignment_hire_agency_type, " - ")[safe_offset(1)]) as assignment_hire_agency_type_desc,
  TRIM(SPLIT(all_staff_report.assignment_work_agency, " - ")[safe_offset(0)]) as assignment_work_agency_cd,
  work_agency_districts.district_name as assignment_work_agency_desc,
  TRIM(SPLIT(all_staff_report.work_agency_type, " - ")[safe_offset(0)]) as work_agency_type_cd,
  TRIM(SPLIT(all_staff_report.work_agency_type, " - ")[safe_offset(1)]) as work_agency_type_desc,

  CASE
    WHEN REGEXP_CONTAINS(all_staff_report.assignment_work_school," - ") THEN TRIM(SPLIT(all_staff_report.assignment_work_school, " - ")[safe_OFFSET(0)])
  ELSE
    ""
  END AS assignment_work_school_cd,
  CASE
    WHEN REGEXP_CONTAINS(all_staff_report.assignment_work_school," - ") THEN TRIM(SPLIT(all_staff_report.assignment_work_school, " - ")[safe_OFFSET(1)])
  ELSE
    TRIM(all_staff_report.assignment_work_school)
  END AS assignment_work_school_desc,
  SAFE_CAST(all_staff_report.assignment_work_cesa_number as STRING) as cesa_num,

  county_codes.county_code as assignment_work_county_cd,
  county_codes.county_name as assignment_work_county_name,
  SAFE_CAST(county_codes.fips_code as INT64) as county_fips_code,

  TRIM(SPLIT(all_staff_report.assignment_work_school_level, " - ")[safe_offset(0)]) as assignment_work_school_level_cd,
  TRIM(SPLIT(all_staff_report.assignment_work_school_level, " - ")[safe_offset(1)]) as assignment_work_school_level_desc,
  TRIM(SPLIT(all_staff_report.assignment_position, " - ")[safe_offset(0)]) as assignment_position_cd,
  TRIM(SPLIT(all_staff_report.assignment_position, " - ")[safe_offset(1)]) as assignment_position_desc,
  all_staff_report.assignment_fte,
  TRIM(all_staff_report.assignment_grades_served) as assignment_grades_served,
  TRIM(all_staff_report.assignment_long_term_substitute) as assignment_long_term_substitute,
  TRIM(all_staff_report.assignment_bilingual_program) as assignment_bilingual_program,
  TRIM(all_staff_report.assignment_alternative_program) as assignment_alternative_program,
  TRIM(all_staff_report.assignment_subcontracted) as assignment_subcontracted,
  TRIM(all_staff_report.assignment_requires_dpi_license) as assignment_requires_dpi_license,
  TRIM(all_staff_report.school_mailing_street_address) as school_mailing_street_address,
  SAFE_CAST(all_staff_report.district_mailing_po_box as INT64) as school_mailing_po_box,
  TRIM(all_staff_report.school_mailing_city) as school_mailing_city,
  TRIM(all_staff_report.school_mailing_state) as school_mailing_state,
  SAFE_CAST(all_staff_report.school_mailing_zip_code as String) as school_mailing_zip_code,
  TRIM(all_staff_report.district_mailing_street_address) as district_mailing_street_address,
  SAFE_CAST(all_staff_report.district_mailing_po_box as INT64) as district_mailing_po_box,
  TRIM(all_staff_report.district_mailing_city) as district_mailing_city,
  TRIM(all_staff_report.district_mailing_state) as district_mailing_state,
  SAFE_CAST(all_staff_report.district_mailing_zip_code as String) as district_mailing_zip_code
FROM
  `wi-dpi-010.2017.2017` all_staff_report
  LEFT JOIN `wi-dpi-010.metadata.wi_dpi_county_fips_codes` county_codes
   ON SAFE_CAST(TRIM(SPLIT(all_staff_report.assignment_work_county, " - ")[safe_offset(0)]) AS INT64) = county_codes.county_code
  LEFT JOIN `wi-dpi-010.metadata.wi_dpi_school_districts` as hire_agency_districts
    ON SAFE_CAST(TRIM(SPLIT(all_staff_report.hire_agency, " - ")[safe_offset(0)]) AS INT64) = hire_agency_districts.lea_code
  LEFT JOIN `wi-dpi-010.metadata.wi_dpi_school_districts` as work_agency_districts
    ON SAFE_CAST(TRIM(SPLIT(all_staff_report.assignment_work_agency, " - ")[safe_offset(0)]) AS INT64) = work_agency_districts.lea_code
SELECT
  all_staff_report.id_nbr,
  TRIM(lower(all_staff_report.first_name)) as first_name,
  TRIM(lower(all_staff_report.last_name)) as last_name,
  SAFE_CAST(all_staff_report.file_number as INT64) as file_number,
  TRIM(all_staff_report.gndr) as gender,
  TRIM(all_staff_report.raceethn) as race_ethnicity_cd,
  race_ethnicity.description as race_ethnicity_desc,
  all_staff_report.birth_year,
  SAFE_CAST(all_staff_report.high_degree as STRING) as high_degree_cd,
  TRIM(highest_degree.description) as high_degree_desc,
  SAFE_CAST(REGEXP_EXTRACT(all_staff_report.year_session, r"^[0-9]{4}") AS INT64) as school_year,
  all_staff_report.cntrct_days as contract_days,
  all_staff_report.local_exp,
  all_staff_report.total_exp,
  all_staff_report.tot_salary as salary,
  all_staff_report.tot_fringe as benefits,
  SAFE_CAST(all_staff_report.staff_cat as INT64) as staff_category_cd,
  TRIM(staff_cat.description) as staff_category_desc,
  LPAD(CAST(all_staff_report.hire_agncy_typ AS STRING), 2, "0") as hire_agency_type_cd,
  hire_agency_type.description as hire_agency_type_desc,
  LPAD(CAST(all_staff_report.work_agncy_typ AS STRING), 2, "0") as work_agency_type_cd,
  work_agency_type.description as work_agency_type_desc,
  all_staff_report.hire_agncy_cd as hire_agency_cd,

  hire_agency_districts.district_name as hire_agency_desc,
  all_staff_report.work_agncy_cd as work_agency_cd,
  work_agency_districts.district_name as work_agency_desc,

  TRIM(all_staff_report.school_cd) as school_cd,
  position.position_type as position_type_cd,
  pos_type.description as position_type_desc,
  all_staff_report.position_cd,
  position.position_description,
  LPAD(SAFE_CAST(all_staff_report.assgn_area_cd AS STRING),4, "0") as assignment_area_cd,
  assignment_area.assignment_area_description,
  TRIM(all_staff_report.low_grd) as low_grade,
  TRIM(all_staff_report.high_grd) as high_grade,
  all_staff_report.lg_sort_cd,
  all_staff_report.hg_sort_cd,
  all_staff_report.bilingual,
  ROUND(all_staff_report.assgn_fte/100,3) as assignment_fte,
  TRIM(all_staff_report.school_name) as school_name,
  TRIM(all_staff_report.grd_level) as school_level_cd,
  grade_level.description as school_level_desc,
  SAFE_CAST(TRIM(all_staff_report.cesa_number) as INT64) as cesa_num,

  county_codes.county_code,
  county_codes.county_name,
  SAFE_CAST(county_codes.fips_code as INT64) as county_fips_code,

  TRIM(all_staff_report.school_mailing_address1) as school_mailing_address1,
  TRIM(all_staff_report.school_mailing_address2) as school_mailing_address2,
  TRIM(all_staff_report.mail_city) as mail_city,
  TRIM(all_staff_report.mail_st) as mail_st,
  TRIM(all_staff_report.mail_zip_cd) as mail_zip_cd,
  TRIM(all_staff_report.school_shipping_address1) as school_shipping_address1,
  TRIM(all_staff_report.school_shipping_address2) as school_shipping_address2,
  TRIM(all_staff_report.mail_city) as ship_city,
  TRIM(all_staff_report.mail_st) as ship_st,
  TRIM(all_staff_report.mail_zip_cd) as ship_zip_cd,
  TRIM(all_staff_report.phone) as phone,
  TRIM(all_staff_report.admin_name) as admin_name,
  TRIM(all_staff_report.former_last_nm) as former_last_name,
  TRIM(all_staff_report.lt_sub) as long_term_sub,
  TRIM(all_staff_report.sub_cntrctd) as sub_contracted
FROM
  `wi-dpi-010.2016.2016_raw_data` all_staff_report
  LEFT JOIN `wi-dpi-010.2016.2016_positions` position
   ON all_staff_report.position_cd = position.code
  LEFT JOIN `wi-dpi-010.2016.2016_assignment_area` assignment_area
   ON all_staff_report.assgn_area_cd = CAST(assignment_area.code as INT64)
  LEFT JOIN `wi-dpi-010.2016.2016_highest_educational_degree` highest_degree
   ON SAFE_CAST(all_staff_report.high_degree as INT64) = highest_degree.code
  LEFT JOIN `wi-dpi-010.2016.2016_staff_category` staff_cat
   ON SAFE_CAST(all_staff_report.staff_cat as INT64) = staff_cat.code
  LEFT JOIN `wi-dpi-010.2016.2016_position_type` pos_type
   ON position.position_type = pos_type.code
  LEFT JOIN `wi-dpi-010.2016.2016_agency_type_NEW` hire_agency_type
   ON all_staff_report.hire_agncy_typ = hire_agency_type.format_code
  LEFT JOIN `wi-dpi-010.2016.2016_agency_type_NEW` work_agency_type
   ON all_staff_report.work_agncy_typ = work_agency_type.format_code
  LEFT JOIN `wi-dpi-010.2016.2016_race` race_ethnicity
   ON TRIM(all_staff_report.raceethn) = race_ethnicity.code
  LEFT JOIN `wi-dpi-010.metadata.wi_dpi_school_districts` as hire_agency_districts
    ON all_staff_report.hire_agncy_cd = hire_agency_districts.lea_code
  LEFT JOIN `wi-dpi-010.metadata.wi_dpi_school_districts` as work_agency_districts
    ON all_staff_report.work_agncy_cd = work_agency_districts.lea_code
  LEFT JOIN `wi-dpi-010.2016.2016_grade_level` grade_level
   ON all_staff_report.grd_level = SAFE_CAST(grade_level.code as STRING)
  LEFT JOIN `wi-dpi-010.metadata.wi_dpi_county_fips_codes` county_codes
   ON all_staff_report.cnty_nbr = county_codes.county_code
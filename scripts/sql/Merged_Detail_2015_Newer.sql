SELECT
  id_nbr as key,
  first_name,
  last_name,
  gender,
  race_ethnicity_cd,
  race_ethnicity_desc,
  birth_year,
  high_degree_cd,
  high_degree_desc,
  school_year as year,
  contract_days,
  local_exp,
  total_exp,
  salary,
  salary_nominal,
  benefits,
  benefits_nominal,
  hire_agency_type_cd,
  hire_agency_type_desc,
  work_agency_type_cd,
  work_agency_type_desc,
  hire_agency_cd,
  hire_agency_desc,
  work_agency_cd,
  work_agency_desc,
  school_cd,
  school_name,
  assignment_area_cd,
  assignment_area_description,
  low_grade,
  high_grade,
  bilingual,
  assign_fte as assignment_fte,
  school_level_cd,
  school_level_desc,
  cesa_num,
  county_number as county_num,
  county_name,
  school_mailing_address1,
  mail_city,
  mail_st,
  mail_zip_cd,
  long_term_sub,
  sub_contracted
FROM
  `wi-dpi-010.2015.2015_Real`
UNION ALL
SELECT
  id_nbr as key,
  first_name,
  last_name,
  gender,
  race_ethnicity_cd,
  race_ethnicity_desc,
  birth_year,
  high_degree_cd,
  high_degree_desc,
  school_year as year,
  contract_days,
  local_exp,
  total_exp,
  salary,
  salary_nominal,
  benefits,
  benefits_nominal,
  hire_agency_type_cd,
  hire_agency_type_desc,
  work_agency_type_cd,
  work_agency_type_desc,
  hire_agency_cd,
  hire_agency_desc,
  work_agency_cd,
  work_agency_desc,
  school_cd,
  school_name,
  assignment_area_cd,
  assignment_area_description as assignment_area_desc,
  low_grade,
  high_grade,
  bilingual,
  assign_fte as assignment_fte,
  school_level_cd,
  school_level_desc,
  cesa_num,
  county_number as county_num,
  county_name,
  school_mailing_address1,
  mail_city,
  mail_st,
  mail_zip_cd,
  long_term_sub,
  sub_contracted
FROM
  `wi-dpi-010.2016.2016_Real`
UNION ALL
SELECT
  research_id as key,
  first_name,
  last_name,
  gender,
  race_ethnicity_cd,
  race_ethnicity_desc,
  birth_year,
  contract_high_degree_cd as high_degree_cd,
  contract_high_degree_desc as high_degree_desc,
  year_session as year,
  contract_days,
  contract_local_experience as local_exp,
  contract_total_experience as total_exp,
  salary,
  salary_nominal,
  benefits,
  benefits_nominal,
  assignment_hire_agency_type_cd as hire_agency_type_cd,
  assignment_hire_agency_type_desc as hire_agency_type_desc,
  work_agency_type_cd,
  work_agency_type_desc,
  hire_agency_cd,
  hire_agency_desc,
  assignment_work_agency_cd as work_agency_cd,
  assignment_work_agency_desc as work_agency_desc,
  assignment_work_school_cd as school_cd,
  assignment_work_school_desc as school_name,
  assignment_area_cd,
  assignment_area_desc,
  substr(assignment_grades_served, 0, 2) as low_grade,
  substr(assignment_grades_served, -2, 2) as high_grade,
  assignment_bilingual_program as bilingual,
  assignment_fte,
  assignment_work_school_level_cd as school_level_cd,
  assignment_work_school_level_desc as school_level_desc,
  cesa_num,
  assignment_work_county_cd as county_number,
  assignment_work_county_name as county_name,
  school_mailing_street_address as school_mailing_address1,
  school_mail_city as mail_city,
  school_mail_st as mail_st,
  school_mailing_zip_code as mail_zip_cd,
  assignment_long_term_substitute as long_term_sub,
  assignment_subcontracted as sub_contracted
FROM
  `wi-dpi-010.2019.2019_Real`

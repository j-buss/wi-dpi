SELECT
  detail.key,
  detail.year,
  master_data.max_first_name as first_name,
  master_data.max_last_name as last_name,
  master_data.max_gender as gender,
  master_data.max_race_ethnicity_cd as race_ethnicity_cd,
  master_data.max_birth_year as birth_year,
  master_data.max_contract_local_experience as contract_local_exprience,
  master_data.max_contract_total_experience as contract_total_exprience,
  master_data.max_contract_high_degree_cd as contract_high_degree_cd,
  detail.contract_days,
  detail.hire_agency_desc,
  detail.work_agency_desc,
  detail.school_name,
  detail.assignment_area_description,
  master_data.total_assignment_fte,
  detail.assignment_fte,
  SAFE_CAST(detail.cesa_num as int64) as cesa_num,
  detail.county_name,
  ROUND((detail.assignment_fte / master_data.total_assignment_fte) * master_data.max_salary,2) as allocated_salary
FROM
  `wi-dpi-010.Merged.detail_2015` as detail
  inner join `wi-dpi-010.Merged.master_data_2015_newer` as master_data
  on (detail.key = master_data.key and detail.year = master_data.year)
WHERE
  master_data.teacher_cnt > 0 and
  detail.assignment_fte is not null
ORDER BY
  master_data.key
SELECT
  real_2018.year_session as year,
  real_2018.research_id as key,
  MAX(real_2018.first_name) as max_first_name,
  MAX(real_2018.last_name) as max_last_name,
  MAX(real_2018.gender) as max_gender,
  MAX(real_2018.race_ethnicity_cd) as max_race_ethnicity_cd,
  MAX(real_2018.birth_year) as max_birth_year,
  MAX(real_2018.contract_high_degree_cd) as max_contract_high_degree_cd,
  MAX(real_2018.contract_local_experience) as max_contract_local_experience,
  MAX(real_2018.contract_total_experience) as max_contract_total_experience,
  MAX(real_2018.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2018.salary)
    ELSE Max(real_2018.salary)
  END AS max_salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2018.benefits)
    ELSE Max(real_2018.benefits)
  END AS max_benefits
FROM
  `wi-dpi-010.2018.2018_Real` real_2018
  INNER JOIN `wi-dpi-010.Merged.pos_class_2015_newer` pos_class
  ON (real_2018.research_id = pos_class.key and pos_class.year = real_2018.year_session)
  INNER JOIN `wi-dpi-010.Merged.role_sum_2015_newer` role_summary
  ON (real_2018.research_id = role_summary.key and role_summary.year = real_2018.year_session)
GROUP BY
  real_2018.year_session,
  real_2018.research_id,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt
UNION ALL
SELECT
  real_2019.year_session as year,
  real_2019.research_id as key,
  MAX(real_2019.first_name) as max_first_name,
  MAX(real_2019.last_name) as max_last_name,
  MAX(real_2019.gender) as max_gender,
  MAX(real_2019.race_ethnicity_cd) as max_race_ethnicity_cd,
  MAX(real_2019.birth_year) as max_birth_year,
  MAX(real_2019.contract_high_degree_cd) as max_contract_high_degree_cd,
  MAX(real_2019.contract_local_experience) as max_contract_local_experience,
  MAX(real_2019.contract_total_experience) as max_contract_total_experience,
  MAX(real_2019.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2019.salary)
    ELSE Max(real_2019.salary)
  END AS max_salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2019.benefits)
    ELSE Max(real_2019.benefits)
  END AS max_benefits
FROM
  `wi-dpi-010.2019.2019_Real` real_2019
  INNER JOIN `wi-dpi-010.Merged.pos_class_2015_newer` pos_class
  ON (real_2019.research_id = pos_class.key and pos_class.year = real_2019.year_session)
  INNER JOIN `wi-dpi-010.Merged.role_sum_2015_newer` role_summary
  ON (real_2019.research_id = role_summary.key and role_summary.year = real_2019.year_session)
GROUP BY
  real_2019.year_session,
  real_2019.research_id,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt
UNION ALL
SELECT
  real_2017.year_session as year,
  real_2017.research_id as key,
  MAX(real_2017.first_name) as max_first_name,
  MAX(real_2017.last_name) as max_last_name,
  MAX(real_2017.gender) as max_gender,
  MAX(real_2017.race_ethnicity_cd) as max_race_ethnicity_cd,
  MAX(real_2017.birth_year) as max_birth_year,
  MAX(real_2017.contract_high_degree_cd) as max_contract_high_degree_cd,
  MAX(real_2017.contract_local_experience) as max_contract_local_experience,
  MAX(real_2017.contract_total_experience) as max_contract_total_experience,
  MAX(real_2017.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2017.salary)
    ELSE Max(real_2017.salary)
  END AS max_salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2017.benefits)
    ELSE Max(real_2017.benefits)
  END AS max_benefits
FROM
  `wi-dpi-010.2017.2017_Real` real_2017
  INNER JOIN `wi-dpi-010.Merged.pos_class_2015_newer` pos_class
  ON (real_2017.research_id = pos_class.key and pos_class.year = real_2017.year_session)
  INNER JOIN `wi-dpi-010.Merged.role_sum_2015_newer` role_summary
  ON (real_2017.research_id = role_summary.key and role_summary.year = real_2017.year_session)
GROUP BY
  real_2017.year_session,
  real_2017.research_id,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt
UNION ALL
SELECT
  real_2016.school_year as year,
  real_2016.id_nbr as key,
  MAX(real_2016.first_name) as max_first_name,
  MAX(real_2016.last_name) as max_last_name,
  MAX(real_2016.gender) as max_gender,
  MAX(real_2016.race_ethnicity_cd) as max_race_ethnicity_cd,
  MAX(real_2016.birth_year) as max_birth_year,
  CAST(MAX(real_2016.high_degree_cd) AS STRING) as max_contract_high_degree_cd,
  MAX(real_2016.local_exp) as max_contract_local_experience,
  MAX(real_2016.total_exp) as max_contract_total_experience,
  MAX(real_2016.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2016.salary)
    ELSE Max(real_2016.salary)
  END AS max_salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2016.benefits)
    ELSE Max(real_2016.benefits)
  END AS max_benefits
FROM
  `wi-dpi-010.2016.2016_Real` real_2016
  INNER JOIN `wi-dpi-010.Merged.pos_class_2015_newer` pos_class
  ON (real_2016.id_nbr = pos_class.key and pos_class.year = real_2016.school_year)
  INNER JOIN `wi-dpi-010.Merged.role_sum_2015_newer` role_summary
  ON (real_2016.id_nbr = role_summary.key and role_summary.year = real_2016.school_year)
GROUP BY
  real_2016.school_year,
  real_2016.id_nbr,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt
UNION ALL
SELECT
  real_2015.school_year as year,
  real_2015.id_nbr as key,
  MAX(real_2015.first_name) as max_first_name,
  MAX(real_2015.last_name) as max_last_name,
  MAX(real_2015.gender) as max_gender,
  MAX(real_2015.race_ethnicity_cd) as max_race_ethnicity_cd,
  MAX(real_2015.birth_year) as max_birth_year,
  CAST(MAX(real_2015.high_degree_cd) AS STRING) as max_contract_high_degree_cd,
  MAX(real_2015.local_exp) as max_contract_local_experience,
  MAX(real_2015.total_exp) as max_contract_total_experience,
  MAX(real_2015.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2015.salary)
    ELSE Max(real_2015.salary)
  END AS max_salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2015.benefits)
    ELSE Max(real_2015.benefits)
  END AS max_benefits
FROM
  `wi-dpi-010.2015.2015_Real` real_2015
  INNER JOIN `wi-dpi-010.Merged.pos_class_2015_newer` pos_class
  ON (real_2015.id_nbr = pos_class.key and pos_class.year = real_2015.school_year)
  INNER JOIN `wi-dpi-010.Merged.role_sum_2015_newer` role_summary
  ON (real_2015.id_nbr = role_summary.key and role_summary.year = real_2015.school_year)
GROUP BY
  real_2015.school_year,
  real_2015.id_nbr,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.total_assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt

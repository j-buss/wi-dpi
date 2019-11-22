SELECT
  "2018" as year,
  real_2018.research_id,
  MAX(real_2018.first_name) as first_name,
  MAX(real_2018.last_name) as last_name,
  MAX(real_2018.gender) as gender,
  MAX(real_2018.race_ethnicity_cd) as race_ethnicity_cd,
  MAX(real_2018.birth_year) as birth_year,
  MAX(real_2018.contract_high_degree_cd) as max_contract_high_degree_cd,
  MAX(real_2018.contract_local_experience) as max_contract_local_experience,
  MAX(real_2018.contract_total_experience) as max_contract_total_experience,
  MAX(real_2018.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2018.salary)
    ELSE Max(real_2018.salary)
  END AS salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2018.benefits)
    ELSE Max(real_2018.benefits)
  END AS Benefits
FROM
  `wi-dpi-010.2018.2018_real` real_2018
  INNER JOIN `wi-dpi-010.Merged.Educator_Position_Classification_by_Year` pos_class
  ON (real_2018.research_id = pos_class.key and pos_class.year = "2018")
  INNER JOIN `wi-dpi-010.Merged.Educator_Role_Summary_by_Year` role_summary
  ON (real_2018.research_id = role_summary.key and role_summary.year = "2018")
GROUP BY
  real_2018.research_id,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt
UNION ALL
SELECT
  "2019" as year,
  real_2019.research_id,
  MAX(real_2019.first_name) as first_name,
  MAX(real_2019.last_name) as last_name,
  MAX(real_2019.gender) as gender,
  MAX(real_2019.race_ethnicity_cd) as race_ethnicity_cd,
  MAX(real_2019.birth_year) as birth_year,
  MAX(real_2019.contract_high_degree_cd) as max_contract_high_degree_cd,
  MAX(real_2019.contract_local_experience) as max_contract_local_experience,
  MAX(real_2019.contract_total_experience) as max_contract_total_experience,
  MAX(real_2019.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2019.salary)
    ELSE Max(real_2019.salary)
  END AS salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2019.benefits)
    ELSE Max(real_2019.benefits)
  END AS Benefits
FROM
  `wi-dpi-010.2019.2019_real` real_2019
  INNER JOIN `wi-dpi-010.Merged.Educator_Position_Classification_by_Year` pos_class
  ON (real_2019.research_id = pos_class.key and pos_class.year = "2019")
  INNER JOIN `wi-dpi-010.Merged.Educator_Role_Summary_by_Year` role_summary
  ON (real_2019.research_id = role_summary.key and role_summary.year = "2019")
GROUP BY
  real_2019.research_id,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt
UNION ALL
SELECT
  "2017" as year,
  real_2017.research_id,
  MAX(real_2017.first_name) as first_name,
  MAX(real_2017.last_name) as last_name,
  MAX(real_2017.gender) as gender,
  MAX(real_2017.race_ethnicity_cd) as race_ethnicity_cd,
  MAX(real_2017.birth_year) as birth_year,
  MAX(real_2017.contract_high_degree_cd) as max_contract_high_degree_cd,
  MAX(real_2017.contract_local_experience) as max_contract_local_experience,
  MAX(real_2017.contract_total_experience) as max_contract_total_experience,
  MAX(real_2017.contract_days) as max_contract_days,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2017.salary)
    ELSE Max(real_2017.salary)
  END AS salary,
  CASE
    WHEN role_summary.contract_cnt > 1 THEN SUM(real_2017.benefits)
    ELSE Max(real_2017.benefits)
  END AS Benefits
FROM
  `wi-dpi-010.2017.2017_real` real_2017
  INNER JOIN `wi-dpi-010.Merged.Educator_Position_Classification_by_Year` pos_class
  ON (real_2017.research_id = pos_class.key and pos_class.year = "2017")
  INNER JOIN `wi-dpi-010.Merged.Educator_Role_Summary_by_Year` role_summary
  ON (real_2017.research_id = role_summary.key and role_summary.year = "2017")
GROUP BY
  real_2017.research_id,
  pos_class.teacher_cnt,
  pos_class.admin_cnt,
  pos_class.other_cnt,
  role_summary.rec_cnt,
  role_summary.assignment_fte,
  role_summary.salary_cnt,
  role_summary.null_salary_cnt,
  role_summary.contract_cnt

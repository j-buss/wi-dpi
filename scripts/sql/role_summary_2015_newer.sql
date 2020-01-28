SELECT
  B.school_year as Year,
  B.id_nbr as key,
  COUNT(*) AS rec_cnt,
  COUNT(B.cesa_num) as cesa_cnt,
  COUNT(B.county_fips_code) as county_cnt,
  COUNT(B.work_agency_desc) as district_cnt,
  COUNT(B.school_name) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS total_assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.school_year,
      A.id_nbr,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.county_fips_code,
      A.work_agency_desc,
      A.school_name,
      CASE WHEN A.Salary <> 0 THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary != 0 THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2015.2015_Real` A) B
GROUP BY
  1,
  2
UNION ALL
SELECT
  B.school_year as Year,
  B.id_nbr as key,
  COUNT(*) AS rec_cnt,
  COUNT(B.cesa_num) as cesa_cnt,
  COUNT(B.county_fips_code) as county_cnt,
  COUNT(B.work_agency_desc) as district_cnt,
  COUNT(B.school_name) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS total_assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.school_year,
      A.id_nbr,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.county_fips_code,
      A.work_agency_desc,
      A.school_name,
      CASE WHEN A.Salary <> 0 THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary != 0 THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2016.2016_Real` A) B
GROUP BY
  1,
  2
UNION ALL
SELECT
  B.year_session as Year,
  B.research_id as key,
  COUNT(*) AS rec_cnt,
  count(distinct B.cesa_num) as cesa_cnt,
  count(distinct B.county_fips_code) as county_cnt,
  count(distinct B.assignment_work_agency_cd) as district_cnt,
  count(distinct B.assignment_work_school_cd) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS total_assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.year_session,
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.county_fips_code,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2017.2017_Real` A) B
GROUP BY
  1,
  2
UNION ALL
SELECT
  B.year_session as Year,
  B.research_id key,
  COUNT(*) AS rec_cnt,
  count(distinct B.cesa_num) as cesa_cnt,
  count(distinct B.county_fips_code) as county_cnt,
  count(distinct B.assignment_work_agency_cd) as district_cnt,
  count(distinct B.assignment_work_school_cd) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS total_assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.year_session,
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.county_fips_code,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2018.2018_Real` A) B
GROUP BY
  1,
  2
UNION ALL
SELECT
  B.year_session as Year,
  B.research_id as key,
  COUNT(*) AS rec_cnt,
  count(distinct B.cesa_num) as cesa_cnt,
  count(distinct B.county_fips_code) as county_cnt,
  count(distinct B.assignment_work_agency_cd) as district_cnt,
  count(distinct B.assignment_work_school_cd) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS total_assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.year_session,
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.county_fips_code,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2019.2019_Real` A) B
GROUP BY
  1,
  2

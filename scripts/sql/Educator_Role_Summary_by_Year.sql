SELECT
  "2015" as Year,
  B.id_nbr as key,
  COUNT(*) AS rec_cnt,
  COUNT(B.cesa_num) as cesa_cnt,
  COUNT(B.county_number) as county_cnt,
  COUNT(B.work_location_name) as district_cnt,
  COUNT(B.school_name) as school_cnt,
  ROUND(SUM(B.assgn_fte)/100,3) AS assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.id_nbr,
      A.salary,
      A.assgn_fte,
      A.cesa_num,
      A.county_number,
      A.work_location_name,
      A.school_name,
      CASE WHEN A.Salary <> 0 THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary != 0 THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2015.2015_Real` A) B
GROUP BY
  B.id_nbr
UNION ALL
SELECT
  "2016" as Year,
  B.id_nbr as key,
  COUNT(*) AS rec_cnt,
  COUNT(B.cesa_num) as cesa_cnt,
  COUNT(B.county_number) as county_cnt,
  COUNT(B.work_location_name) as district_cnt,
  COUNT(B.school_name) as school_cnt,
  ROUND(SUM(B.assgn_fte)/100,3) AS assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.id_nbr,
      A.salary,
      A.assgn_fte,
      A.cesa_num,
      A.county_number,
      A.work_location_name,
      A.school_name,
      CASE WHEN A.Salary <> 0 THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary != 0 THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2016.2016_Real` A) B
GROUP BY
  B.id_nbr
UNION ALL
SELECT
  "2017" as Year,
  B.research_id as key,
  COUNT(*) AS rec_cnt,
  count(distinct B.cesa_num) as cesa_cnt,
  count(distinct B.assignment_work_county_cd) as county_cnt,
  count(distinct B.assignment_work_agency_cd) as district_cnt,
  count(distinct B.assignment_work_school_cd) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.assignment_work_county_cd,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2017.2017_Real` A) B
GROUP BY
  B.research_id
UNION ALL
SELECT
  "2018" as Year,
  B.research_id key,
  COUNT(*) AS rec_cnt,
  count(distinct B.cesa_num) as cesa_cnt,
  count(distinct B.assignment_work_county_cd) as county_cnt,
  count(distinct B.assignment_work_agency_cd) as district_cnt,
  count(distinct B.assignment_work_school_cd) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.assignment_work_county_cd,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2018.2018_Real` A) B
GROUP BY
  B.research_id
UNION ALL
SELECT
  "2019" as Year,
  B.research_id as key,
  COUNT(*) AS rec_cnt,
  count(distinct B.cesa_num) as cesa_cnt,
  count(distinct B.assignment_work_county_cd) as county_cnt,
  count(distinct B.assignment_work_agency_cd) as district_cnt,
  count(distinct B.assignment_work_school_cd) as school_cnt,
  ROUND(SUM(B.assignment_fte),3) AS assignment_fte,
  COUNT(distinct B.salary) AS contract_cnt,
  SUM(B.salary_cnt) AS salary_cnt,
  SUM(B.null_salary_cnt) AS null_salary_cnt
FROM
  (SELECT
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.assignment_work_county_cd,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS salary_cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS null_salary_cnt
    FROM
      `wi-dpi-010.2019.2019_Real` A) B
GROUP BY
  B.research_id
SELECT
  "2015" as Year,
  B.id_nbr as key,
  COUNT(*) AS Rec_Cnt,
  ROUND(SUM(B.assgn_fte),3) AS Assignment_FTE,
  COUNT(distinct B.salary) AS Contract_Cnt,
  SUM(B.Salary_Cnt) AS Salary_Cnt,
  SUM(B.Null_Salary_Cnt) AS Null_Salary_Cnt
FROM
  (SELECT
      A.id_nbr,
      A.salary,
      A.assgn_fte,
      CASE WHEN A.Salary <> 0 THEN 1 ELSE 0 END AS Salary_Cnt,
      CASE WHEN A.Salary != 0 THEN 1 ELSE 0 END AS Null_Salary_Cnt
    FROM
      `wi-dpi-010.2015.2015_BASE` A) B
GROUP BY
  B.id_nbr
UNION ALL
SELECT
  "2016" as Year,
  B.id_nbr as key,
  COUNT(*) AS Rec_Cnt,
  ROUND(SUM(B.assgn_fte),3) AS Assignment_FTE,
  COUNT(distinct B.salary) AS Contract_Cnt,
  SUM(B.Salary_Cnt) AS Salary_Cnt,
  SUM(B.Null_Salary_Cnt) AS Null_Salary_Cnt
FROM
  (SELECT
      A.id_nbr,
      A.salary,
      A.assgn_fte,
      CASE WHEN A.Salary <> 0 THEN 1 ELSE 0 END AS Salary_Cnt,
      CASE WHEN A.Salary != 0 THEN 1 ELSE 0 END AS Null_Salary_Cnt
    FROM
      `wi-dpi-010.2016.2016_BASE` A) B
GROUP BY
  B.id_nbr
UNION ALL
SELECT
  "2017" as Year,
  B.research_id as key,
  COUNT(*) AS Rec_Cnt,
  count(distinct B.cesa_num) as Cesa_Cnt,
  count(distinct B.assignment_work_county_cd) as County_Cnt,
  count(distinct B.assignment_work_agency_cd) as District_Cnt,
  count(distinct B.assignment_work_school_cd) as School_Cnt,
  ROUND(SUM(B.assignment_fte),3) AS Assignment_FTE,
  COUNT(distinct B.salary) AS Contract_Cnt,
  SUM(B.Salary_Cnt) AS Salary_Cnt,
  SUM(B.Null_Salary_Cnt) AS Null_Salary_Cnt
FROM
  (SELECT
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.assignment_work_county_cd,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS Salary_Cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS Null_Salary_Cnt
    FROM
      `wi-dpi-010.2017.2017_BASE` A) B
GROUP BY
  B.research_id
UNION ALL
SELECT
  "2018" as Year,
  B.research_id key,
  COUNT(*) AS Rec_Cnt,
  count(distinct B.cesa_num) as Cesa_Cnt,
  count(distinct B.assignment_work_county_cd) as County_Cnt,
  count(distinct B.assignment_work_agency_cd) as District_Cnt,
  count(distinct B.assignment_work_school_cd) as School_Cnt,
  ROUND(SUM(B.assignment_fte),3) AS Assignment_FTE,
  COUNT(distinct B.salary) AS Contract_Cnt,
  SUM(B.Salary_Cnt) AS Salary_Cnt,
  SUM(B.Null_Salary_Cnt) AS Null_Salary_Cnt
FROM
  (SELECT
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.assignment_work_county_cd,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS Salary_Cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS Null_Salary_Cnt
    FROM
      `wi-dpi-010.2018.2018_BASE` A) B
GROUP BY
  B.research_id
UNION ALL
SELECT
  "2019" as Year,
  B.research_id as key,
  COUNT(*) AS Rec_Cnt,
  count(distinct B.cesa_num) as Cesa_Cnt,
  count(distinct B.assignment_work_county_cd) as County_Cnt,
  count(distinct B.assignment_work_agency_cd) as District_Cnt,
  count(distinct B.assignment_work_school_cd) as School_Cnt,
  ROUND(SUM(B.assignment_fte),3) AS Assignment_FTE,
  COUNT(distinct B.salary) AS Contract_Cnt,
  SUM(B.Salary_Cnt) AS Salary_Cnt,
  SUM(B.Null_Salary_Cnt) AS Null_Salary_Cnt
FROM
  (SELECT
      A.research_id,
      A.salary,
      A.assignment_fte,
      A.cesa_num,
      A.assignment_work_county_cd,
      A.assignment_work_agency_cd,
      A.assignment_work_school_cd,
      CASE WHEN A.Salary is Not Null THEN 1 ELSE 0 END AS Salary_Cnt,
      CASE WHEN A.Salary is Null THEN 1 ELSE 0 END AS Null_Salary_Cnt
    FROM
      `wi-dpi-010.2019.2019_BASE` A) B
GROUP BY
  B.research_id
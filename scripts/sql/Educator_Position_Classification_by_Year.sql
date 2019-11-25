SELECT
  A.year,
  A.key,
  SUM(CASE WHEN A.position_classification = 'TEACHER' THEN 1 ELSE 0 END) as teacher_cnt,
  SUM(CASE WHEN A.position_classification = 'ADMINISTRATOR' THEN 1 ELSE 0 END) as admin_cnt,
  SUM(CASE WHEN A.position_classification = 'OTHER' THEN 1 ELSE 0 END) as other_cnt
FROM
  (SELECT
    all_staff_report.school_year as year,
    all_staff_report.id_nbr AS key,
    CASE
      WHEN all_staff_report.position_type_desc = 'Licensed' AND all_staff_report.position_description =   'Teacher' THEN 'TEACHER'
      WHEN all_staff_report.position_type_desc = 'Administrative' THEN 'ADMINISTRATOR'
    ELSE
      'OTHER'
    END AS position_classification
  FROM
  `wi-dpi-010.2015.2015_Real` all_staff_report) A
GROUP BY
  A.year,
  A.key
UNION ALL
SELECT
  A.year,
  A.key,
  SUM(CASE WHEN A.position_classification = 'TEACHER' THEN 1 ELSE 0 END) as teacher_cnt,
  SUM(CASE WHEN A.position_classification = 'ADMINISTRATOR' THEN 1 ELSE 0 END) as admin_cnt,
  SUM(CASE WHEN A.position_classification = 'OTHER' THEN 1 ELSE 0 END) as other_cnt
FROM
  (SELECT
    all_staff_report.school_year as year,
    all_staff_report.id_nbr AS key,
    CASE
      WHEN all_staff_report.position_type_desc = 'Licensed' AND all_staff_report.position_description =   'Teacher' THEN 'TEACHER'
      WHEN all_staff_report.position_type_desc = 'Administrative' THEN 'ADMINISTRATOR'
    ELSE
      'OTHER'
    END AS position_classification
  FROM
  `wi-dpi-010.2016.2016_Real` all_staff_report) A
GROUP BY
  A.year,
  A.key
UNION ALL
SELECT
  A.year,
  A.key,
  sum(A.t_cnt) as teacher_cnt,
  sum(A.a_cnt) as admin_cnt,
  sum(A.o_cnt) as other_cnt
FROM
  (SELECT
    all_staff_report.year_session as year,
    all_staff_report.research_id AS key,
    CASE WHEN all_staff_report.position_classification = 'Teachers' THEN 1 ELSE 0 END AS t_cnt,
    CASE WHEN all_staff_report.position_classification = 'Administrators' THEN 1 ELSE 0 END AS a_cnt,
    CASE
      WHEN (all_staff_report.position_classification NOT IN ('Administrators','Teachers')) THEN 1
      WHEN all_staff_report.position_classification IS NULL THEN 1
      ELSE 0
    END AS o_cnt
  FROM
    `wi-dpi-010.2018.2018_Real` all_staff_report) A
GROUP BY
  1, 2
UNION ALL
SELECT
  A.year,
  A.key,
  sum(A.t_cnt) as teacher_cnt,
  sum(A.a_cnt) as admin_cnt,
  sum(A.o_cnt) as other_cnt
FROM
  (SELECT
    all_staff_report.year_session as year,
    all_staff_report.research_id AS key,
    CASE WHEN all_staff_report.position_classification = 'Teachers' THEN 1 ELSE 0 END AS t_cnt,
    CASE WHEN all_staff_report.position_classification = 'Administrators' THEN 1 ELSE 0 END AS a_cnt,
    CASE
      WHEN (all_staff_report.position_classification NOT IN ('Administrators','Teachers')) THEN 1
      WHEN all_staff_report.position_classification IS NULL THEN 1
      ELSE 0
    END AS o_cnt
  FROM
    `wi-dpi-010.2017.2017_Real` all_staff_report) A
GROUP BY
  1, 2
UNION ALL
SELECT
  A.year,
  A.key,
  sum(A.t_cnt) as teacher_cnt,
  sum(A.a_cnt) as admin_cnt,
  sum(A.o_cnt) as other_cnt
FROM
  (SELECT
    all_staff_report.year_session as year,
    all_staff_report.research_id AS key,
    CASE WHEN all_staff_report.position_classification = 'Teachers' THEN 1 ELSE 0 END AS t_cnt,
    CASE WHEN all_staff_report.position_classification = 'Administrators' THEN 1 ELSE 0 END AS a_cnt,
    CASE
      WHEN (all_staff_report.position_classification NOT IN ('Administrators','Teachers')) THEN 1
      WHEN all_staff_report.position_classification IS NULL THEN 1
      ELSE 0
    END AS o_cnt
  FROM
    `wi-dpi-010.2019.2019_Real` all_staff_report) A
GROUP BY
  1, 2

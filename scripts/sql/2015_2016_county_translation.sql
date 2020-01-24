WITH distinct_county_array as
(WITH distinct_counties as
(SELECT
  distinct county_name
FROM
  (SELECT
    county_name
  FROM
    `wi-dpi-010.2015.2015_Nominal`
  UNION ALL
  SELECT
     county_name
  FROM
     `wi-dpi-010.2016.2016_Nominal`
  ))
SELECT
  county_name,
  SPLIT(county_name, " ") AS county_name_array
FROM
  distinct_counties)
SELECT
  county_name,
  ARRAY_TO_STRING(ARRAY(
    SELECT * EXCEPT(OFFSET)
    FROM distinct_county_array.county_name_array WITH OFFSET
    WHERE OFFSET < ARRAY_LENGTH(distinct_county_array.county_name_array) - 1
  )," ") as new_county_name
FROM
  distinct_county_array
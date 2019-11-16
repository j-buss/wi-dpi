SELECT
  code,
  CASE
    WHEN length(CAST(code AS STRING)) = 1 THEN LPAD(CAST(code as STRING), 2, "0")
    ELSE code
    END AS format_code,
  description
FROM
  `wi-dpi-010.2016.2016_agency_type`

SELECT
  Gender,
  ROUND(SUM(Total_Salary) / COUNT(Total_Salary),2)
FROM
  landing_009.subset
WHERE
  Total_Salary IS NOT NULL
GROUP BY
 1

SELECT
  Gender,
  Contract_Total_Experience,
  Contract_High_Degree,
  EXTRACT(Year from CURRENT_DATE) - Birth_Year as Age,
  ROUND(SUM(Total_Salary) / COUNT(Total_Salary),2) as Salary
FROM
  landing_009.subset
WHERE
  Total_Salary IS NOT NULL
GROUP BY
 1, 2, 3, 4

SELECT
  Real_2019.research_id,
  MAX(Real_2019.first_name),
  MAX(Real_2019.last_name),
  MAX(Real_2019.gender),
  MAX(Real_2019.race_ethnicity_cd),
  MAX(Real_2019.race_ethnicity_desc),
  MAX(Real_2019.birth_year),
  MAX(Real_2019.contract_high_degree_cd) as max_contract_high_degree_cd,
  MAX(Real_2019.contract_local_experience) as max_contract_local_experience,
  MAX(Real_2019.contract_total_experience) as max_contract_total_experience,
  MAX(Real_2019.contract_days) as max_contract_days
FROM
  `wi-dpi-010.2019.2019_Real` Real_2019
  LEFT JOIN `wi-dpi-010.Merged.Educator_Position_Classification_by_Year` pos_class
  ON (Real_2019.research_id = pos_class.key and pos_class.year = "2019")
GROUP BY
  Real_2019.research_id

#!/bin/sh

# 2015
# python3 ../../process/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2015_01_Raw_Combine.sql "2015" "2015_Nominal"

# 2016
# python3 ../../process/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2016_01_New_Agency_Type.sql "2016" "2016_agency_type_NEW"
# python3 ../../process/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2016_02_Raw_Combine.sql "2016" "2016_Nominal"

# 2017
# python3 ../../process/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2017_01_Extract_Desc.sql "2017" "2017_Nominal"

# 2018
# python3 ../../process/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2018_01_Extract_Desc.sql "2018" "2018_Nominal"

# 2019
# python3 ../../process/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2019_01_Extract_Desc.sql "2019" "2019_Real"

# Run Processing for Inflation Adjustment
#    may require export PYTHONPATH=$PYTHONPATH:`pwd` from the "wi-dpi-analysis" directory
# python3 process/adjInflation.py .gcp/API_process_data.json config/bq_adjInflation.json

# Create Educator Summaries by Year
# python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/Educator_Role_Summary_by_Year.sql "Merged" "Educator_Role_Summary_by_Year"
# python3 process/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/Educator_Position_Classification_by_Year.sql "Merged" "Educator_Position_Classification_by_Year"

# Create
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/Yearly_Master_Data.sql "Merged" "Master_Data_by_Year"
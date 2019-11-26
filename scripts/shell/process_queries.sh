#!/bin/sh

# 2015
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/2015_01_Raw_Combine.sql "2015" "2015_Nominal"

# 2016
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/2016_01_New_Agency_Type.sql "2016" "2016_agency_type_NEW"
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/2016_02_Raw_Combine.sql "2016" "2016_Nominal"

# 2017
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/2017_01_Extract_Desc.sql "2017" "2017_Nominal"

# 2018
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/2018_01_Extract_Desc.sql "2018" "2018_Nominal"

# 2019
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/2019_01_Extract_Desc.sql "2019" "2019_Real"

# Run Processing for Inflation Adjustment
#    may require export PYTHONPATH=$PYTHONPATH:`pwd` from the "wi-dpi-analysis" directory
python3 process/adjInflation.py .gcp/API_process_data.json config/bq_adjInflation.json

# Create Educator Summaries by Year
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/role_summary_2015_newer.sql "Merged" "role_sum_2015_newer"
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/pos_classification_2015_newer.sql "Merged" "pos_class_2015_newer"

# Create Master Data by YEar
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/master_data_by_year_2015_newer.sql "Merged" "master_data_2015_newer"

# Create Merged Detail 2015 Newer
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/detail_2015_newer.sql "Merged" "detail_2015"

# Combine Merged Data and Master Data
python3 process/createTableFromSQL.py .gcp/API_process_data.json scripts/sql/flattened_2015_newer.sql "Merged" "flattened_2015_newer"

#!/bin/sh
#python3 ../../pipeline/python/process/bqLoad/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2015_01_Raw_Combine.sql "2015" "2015_BASE"
#python3 ../../pipeline/python/process/bqLoad/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2016_01_Raw_Combine.sql "2016" "2016_BASE"
#python3 ../../pipeline/python/process/bqLoad/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2017_01_Extract_Desc.sql "2017" "2017_BASE"
#python3 ../../pipeline/python/process/bqLoad/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2018_01_Extract_Desc.sql "2018" "2018_BASE"
#python3 ../../pipeline/python/process/bqLoad/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2019_01_Extract_Desc.sql "2019" "2019_BASE"

# Create summarize by educator
python3 ../../pipeline/python/process/bqLoad/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/Educator_Role_Summary_by_Year.sql "Merged" "Educator_Role_Summary_by_Year"

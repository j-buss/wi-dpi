#!/bin/sh
python3 ../../pipeline/python/process/bqLoad/createTableFromSQL.py ../../.gcp/API_process_data.json ../sql/2016_01_Raw_Combine.sql "2016" "2016_Raw_Combine"

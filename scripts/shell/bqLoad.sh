#!/bin/sh
# python3 ../../pipeline/python/process/bqLoad/loadBQStaging.py ../../config/2015_bq_load_config.json ../../.gcp/API_process_data.json
# python3 ../../pipeline/python/process/bqLoad/loadBQStaging.py ../../config/2016_bq_load_config.json ../../.gcp/API_process_data.json
# python3 ../../pipeline/python/process/bqLoad/loadBQStaging.py ../../config/2017_bq_load_config.json ../../.gcp/API_process_data.json
# python3 ../../pipeline/python/process/bqLoad/loadBQStaging.py ../../config/2018_bq_load_config.json ../../.gcp/API_process_data.json
# python3 ../../pipeline/python/process/bqLoad/loadBQStaging.py ../../config/2019_bq_load_config.json ../../.gcp/API_process_data.json
python3 process/loadBQStaging.py config/metadata_config.json .gcp/API_process_data.json

from google.cloud import bigquery
from google.cloud import storage
from google.oauth2 import service_account

import sys
import logging
import json
import pandas as pd
import os
from io import StringIO

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)


def clean_column_headers(columns):
    return columns.str.strip().str.lower().str.replace(' ', '_').str.replace('(', '').str.replace(')', '').str.replace(
        '.', '_').str.replace('/', '_').str.replace("'", "")


def load_credentials(api_file):
    try:
        with open(api_file) as source:
            info = json.load(source)
        creds = service_account.Credentials.from_service_account_info(info)
        logging.debug("Successful authorization")

    except FileNotFoundError:
        print("Error loading credentials file.")
        print("Unable to find file: " + api_file)
        print("Exiting now.")
        sys.exit(1)

    return creds


def load_bq_from_csv(config_dict, credentials):

    project_id = config_dict['project_id']
    bucket_name = config_dict['bucket_name']
    source_blob_name = config_dict['source_blob_name']
    dataset_name = config_dict['dataset_name']
    target_table_name = config_dict['name']

    source_blob_basename, source_blob_ext = os.path.splitext(source_blob_name)

    bq_client = bigquery.Client(project=project_id, credentials=credentials)
    storage_client = storage.Client(project=project_id, credentials=credentials)

    source_bucket = storage_client.get_bucket(bucket_name)
    source_blob = source_bucket.blob(source_blob_name)

    data = source_blob.download_as_string()
    df = pd.read_csv(StringIO(data.decode('utf-8')), low_memory=False)
    df.columns = clean_column_headers(df.columns)
    print("Loading: " + dataset_name + '.' + source_blob_basename)
    df.to_gbq(dataset_name + '.' + target_table_name, project_id=project_id, if_exists='replace')
    print("Finished load of: " + dataset_name + '.' + source_blob_basename)


if __name__ == "__main__":

    # configuration_file = sys.argv[1]
    configuration_file = "/home/jeremyfbuss/wi-dpi-analysis/.gcp/bq_load_config.json"
    credentials = load_credentials("/home/jeremyfbuss/wi-dpi-analysis/.gcp/API_process_data.json")

    with open(configuration_file) as config_file:
        data = json.load(config_file)

    for json_dict in data:
        if json_dict['type'] == "csv":
            load_bq_from_csv(json_dict, credentials)


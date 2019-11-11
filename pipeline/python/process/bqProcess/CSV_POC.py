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


if __name__ == "__main__":

    project_id = 'wi-dpi-010'
    bucket_name = 'staging-008'
    dataset_name = 'test_staging'
    source_blob_name = "2019.csv"
    source_blob_basename, source_blob_ext = os.path.splitext(source_blob_name)

    credentials = load_credentials("/home/jeremyfbuss/wi-dpi-analysis/.gcp/API_process_data.json")

    bq_client = bigquery.Client(project=project_id, credentials=credentials)
    storage_client = storage.Client(project=project_id, credentials=credentials)

    source_bucket = storage_client.get_bucket(bucket_name)
    source_blob = source_bucket.blob(source_blob_name)

    data = source_blob.download_as_string()
    df = pd.read_csv(StringIO(data.decode('utf-8')), low_memory=False)
    # df = pd.read_csv(data)
    df.columns = clean_column_headers(df.columns)
    logging.debug("Loading: " + dataset_name + '.' + source_blob_basename)
    df.to_gbq(dataset_name + '.' + source_blob_basename, project_id=project_id, if_exists='replace')
    logging.debug("Finished load of: " + dataset_name + '.' + source_blob_basename)

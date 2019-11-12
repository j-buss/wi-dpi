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
        '.', '_').str.replace('/', '_').str.replace("'", "").str.replace(":", "_")


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
    del_rows = config_dict['del_rows']
    del_cols = config_dict['del_cols']
    logging.debug(config_dict)

    source_blob_basename, source_blob_ext = os.path.splitext(source_blob_name)

    bq_client = bigquery.Client(project=project_id, credentials=credentials)
    storage_client = storage.Client(project=project_id, credentials=credentials)

    source_bucket = storage_client.get_bucket(bucket_name)
    source_blob = source_bucket.blob(source_blob_name)

    data = source_blob.download_as_string()
    df = pd.read_csv(StringIO(data.decode('utf-8')), skiprows=del_rows, low_memory=False)
    #df = df.iloc[3:,1:]
    print(df)
    #if len(del_rows) >= 1:
    #    logging.debug("Delete Rows: " + str(del_rows))
        # for i in reversed(del_rows):

        # logging.debug("Dropping row: " + str(i))
        # df.drop(df.index[i], inplace=True)
    #    df.drop(del_rows, inplace=True)
    #if len(del_cols) >= 1:
    #    logging.debug("Delete Cols: " + str(del_cols))
    #    for j in reversed(del_cols):
    #        column_numbers = [x for x in range(df.shape[1])]
    #        column_numbers.remove(j)  # removing column integer index 0
    #    df = df.iloc[:, column_numbers]
    df.columns = df.iloc[0]
    #df = df.reindex(df.index.drop(0)).reset_index(drop=True)
    df.columns = clean_column_headers(df.columns)
    print(df)
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


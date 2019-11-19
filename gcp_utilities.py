from google.cloud import storage
from google.cloud import bigquery
from google.oauth2 import service_account
from google.api_core import exceptions

import sys
import logging
import json
import pandas as pd
import os
from io import StringIO


def load_gcp_credentials(api_file):
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


def create_bq_ds(client, dataset_name):
    dataset_id = "{}.{}".format(client.project, dataset_name)
    dataset = bigquery.Dataset(dataset_id)
    dataset.location = "US"

    try:
        dataset = client.create_dataset(dataset)
        print("Created dataset {}.{}".format(client.project, dataset_name))
    except exceptions.Conflict:
        logging.debug("Dataset {}.{} already exists".format(client.project, dataset_name))


def delete_bq_ds(client, project_id, dataset_name):
    dataset_id = "{}.{}".format(project_id, dataset_name)
    client.delete_dataset(dataset_id, delete_contents=True, not_found_ok=True)


def csv_to_bq_tbl(config_dict, credentials):

    project_id = config_dict['project_id']
    bucket_name = config_dict['bucket_name']
    source_blob_name = config_dict['source_blob_name']
    dataset_name = config_dict['dataset_name']
    target_table_name = config_dict['name']
    del_rows = config_dict['del_rows']
    del_cols = config_dict['del_cols']
    logging.debug(config_dict)
    source_blob_basename, source_blob_ext = os.path.splitext(source_blob_name)

    bigquery_client = bigquery.Client(project=project_id, credentials=credentials)
    storage_client = storage.Client(project=project_id, credentials=credentials)
    source_bucket = storage_client.get_bucket(bucket_name)
    source_blob = source_bucket.blob(source_blob_name)
    print("Loading: " + dataset_name + '.' + source_blob_basename)

    create_dataset(bigquery_client, dataset_name)

    data = source_blob.download_as_string()
    if len(del_cols) > 0:
        df = pd.read_csv(StringIO(data.decode('utf-8')), skiprows=del_rows, low_memory=False)
    else:
        df = pd.read_csv(StringIO(data.decode('utf-8')), low_memory=False)

    if len(del_cols) > 0:
        df.drop(df.columns[del_cols], axis=1, inplace=True)

    df.columns = clean_column_headers(df.columns)
    logging.debug(df.head)
    df.to_gbq(dataset_name + '.' + target_table_name, project_id=project_id, credentials=credentials, if_exists='replace')
    print("-----Finished load of: " + dataset_name + '.' + source_blob_basename)
    print("\n")

def load_df_from_bq(sql, credentials):
    pd.read_gbq(sql)

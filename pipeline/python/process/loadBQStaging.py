# import numpy as np
# import pandas as pd
from google.cloud import bigquery
from google.api_core import exceptions
from google.cloud import storage
import logging
import json

# from io import StringIO
# import re
# import collections
from google.oauth2 import service_account

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)


def create_dataset(client, project_id, dataset_name):
    dataset_id = "{}.{}".format(project_id, dataset_name)
    dataset = bigquery.Dataset(dataset_id)
    dataset.location = "US"

    dataset = client.create_dataset(dataset)
    print("Created dataset {}.{}".format(client.project, dataset.dataset_id))


def delete_dataset(client, project_id, dataset_name):
    dataset_id = "{}.{}".format(project_id, dataset_name)
    client.delete_dataset(dataset_id, delete_contents=True, not_found_ok=True)


def return_blob_list(project_id, bucket_name):
    """Lists all the blobs in the bucket."""
    storage_client = storage.Client(project=project_id)
    bucket = storage_client.get_bucket(bucket_name)

    blobs = bucket.list_blobs()
    return blobs


def clean_column_headers(columns):
    return columns.str.strip().str.lower().str.replace(' ', '_').str.replace('(', '').str.replace(')', '').str.replace(
        '.', '_').str.replace('/', '_').str.replace("'", "")


def load_credentials(api_file):
    try:
        with open(api_file) as source:
            info = json.load(source)
        credentials = service_account.Credentials.from_service_account_info(info)
        logging.debug("Successful authorization")

    except FileNotFoundError:
        print("Error loading credentials file.")
        print("Unable to find file: " + api_file)
        print("Exiting now.")
        sys.exit(1)

    return credentials


def create_table_csv(client, project_id, blob_uri, dataset_id):
    # from google.cloud import bigquery
    # client = bigquery.Client()
    # dataset_id = 'my_dataset'

    dataset_ref = client.dataset(dataset_id)
    job_config = bigquery.LoadJobConfig()
    #job_config.schema = [
    #    bigquery.SchemaField("name", "STRING"),
    #    bigquery.SchemaField("post_abbr", "STRING"),
    #]
    job_config.skip_leading_rows = 1
    # The source format defaults to CSV, so the line below is optional.
    job_config.source_format = bigquery.SourceFormat.CSV
    uri = "gs://cloud-samples-data/bigquery/us-states/us-states.csv"

    load_job = client.load_table_from_uri(
        uri, dataset_ref.table("us_states"), job_config=job_config
    )  # API request
    print("Starting job {}".format(load_job.job_id))

    load_job.result()  # Waits for table load to complete.
    print("Job finished.")

    destination_table = client.get_table(dataset_ref.table("us_states"))
    print("Loaded {} rows.".format(destination_table.num_rows))
    data_blob = bucket.get_blob(blob.fullname)
    data = data_blob.download_as_string()
    df = pd.read_csv(StringIO(data.decode('utf-8')), low_memory=False)
    df.columns = clean_column_headers(df.columns)
    print(landing_dataset_name + '.' + blob.file)
    df.to_gbq(landing_dataset_name + '.' + blob.file, project_id=project_id, if_exists='replace')


def create_table_fwf():
    for blob in list_of_blobs:
        if blob.file_type == 'csv':
            data_blob = bucket.get_blob(blob.fullname)
            data = data_blob.download_as_string()
            df = pd.read_csv(StringIO(data.decode('utf-8')), low_memory=False)
            df.columns = clean_column_headers(df.columns)
            print(landing_dataset_name + '.' + blob.file)
            df.to_gbq(landing_dataset_name + '.' + blob.file, project_id=project_id, if_exists='replace')
        elif blob.file_type == 'fwf':
            data_blob = bucket.get_blob(blob.fullname)
            data = data_blob.download_as_string()
            metadata_file = \
            [x_blob.source + '/' + x_blob.year + '/' + x_blob.file + '.' + x_blob.file_type for x_blob in list_of_blobs \
             if (x_blob.file == blob.file and x_blob.file_type != blob.file_type)][0]
            metadata_blob = bucket.get_blob(metadata_file)
            metadata = metadata_blob.download_as_string()
            metadata_df = pd.read_csv(StringIO(metadata.decode('utf-8')))
            col_widths = metadata_df['length'].apply(int)
            col_names = metadata_df['name']
            df = pd.read_fwf(StringIO(data.decode('utf-8')), widths=col_widths, names=col_names)
            df.columns = clean_column_headers(df.columns)
            print(landing_dataset_name + '.' + blob.file)
            df.to_gbq(landing_dataset_name + '.' + blob.file, project_id=project_id, if_exists='replace')


if __name__ == "__main__":

    project_id = 'wi-dpi-010'
    staging_data_bucket_name = 'landing-009'

    landing_dataset_name = 'landing_001'
    refined_dataset_name = 'refined_001'
    creds = load_credentials("/home/jeremyfbuss/wi-dpi-analysis/.gcp/API_Data_Processing_Service_Account.json")

    bq_client = bigquery.Client(project=project_id, credentials=creds)
    try:
        create_dataset(bq_client, project_id, landing_dataset_name)
    except exceptions.Conflict:
        print("Dataset: " + landing_dataset_name + " already exists in project: " + project_id)



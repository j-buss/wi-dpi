from google.cloud import bigquery
from google.oauth2 import service_account
import json
import logging
import sys


def load_credentials(api_file):
    try:
        with open(api_file) as source:
            info = json.load(source)
        creds = service_account.Credentials.from_service_account_info(info)
        project_id = info["project_id"]
        logging.debug("Successful authorization")

    except FileNotFoundError:
        print("Error loading credentials file.")
        print("Unable to find file: " + api_file)
        print("Exiting now.")
        sys.exit(1)

    return creds, project_id


def create_tbl_w_sql(bq_client, sql_file_name, dataset_name, table_name):
    job_config = bigquery.QueryJobConfig()
    
    # Set the destination table
    table_ref = bq_client.dataset(dataset_name).table(table_name)
    job_config.destination = table_ref
    job_config.write_disposition = "WRITE_TRUNCATE"
    with open(sql_file_name, "r") as f:
        sql = f.read()

    # Start the query, passing in the extra configuration.
    query_job = bq_client.query(
        sql,
        # Location must match that of the dataset(s) referenced in the query
        # and of the destination table.
        location='US',
        job_config=job_config)  # API request - starts the query

    query_job.result()  # Waits for the query to finish
    print('Query results loaded to table {}'.format(table_ref.path))


if __name__ == "__main__":

    if len(sys.argv) != 5:
        print("Usage: python createTableFromSQL.py  CREDENTIAL_FILE  SQL_FILE_NAME  DATASET_NAME  TABLE_NAME")
        sys.exit(1)

    credential_file = sys.argv[1]
    sql_file_name = sys.argv[2]
    dataset_name = sys.argv[3]
    table_name = sys.argv[4]

    credentials, project_id = load_credentials(credential_file)
    bigquery_client = bigquery.Client(project=project_id, credentials=credentials)

    create_tbl_w_sql(bigquery_client, sql_file_name, dataset_name, table_name)

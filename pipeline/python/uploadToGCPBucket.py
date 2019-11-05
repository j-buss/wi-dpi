import logging
import sys
import json
import os
from google.cloud import storage
from google.oauth2 import service_account

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
logging.disable(logging.CRITICAL)


def upload_blob_skinny(bucket, source_file_name, destination_blob_name):
    """Uploads a file to the bucket. Pass in storage client and bucket"""
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(source_file_name)
    print('File {} uploaded to {}.'.format(
        source_file_name,
        destination_blob_name))


def load_credentials(api_file):
    try:
        with open(api_file) as source:
            info = json.load(source)
        storage_credentials = service_account.Credentials.from_service_account_info(info)
        logging.debug("Successful authorization")

    except FileNotFoundError:
        print("Error loading credentials file.")
        print("Unable to find file: " + api_file)
        print("Exiting now.")
        sys.exit(1)

    return storage_credentials


def upload_dir_to_bucket(source_directory, bucket_name, bucket_folder, project_id, credential_file):
    credentials = load_credentials(credential_file)
    storage_client = storage.Client(project=project_id, credentials=credentials)
    bucket = storage_client.get_bucket(bucket_name)

    source_directory = os.path.abspath(source_directory)
    for folder_name, sub_folders, file_names in os.walk(source_directory):
        for file_name in file_names:
            source_filename = os.path.join(folder_name, file_name)
            destination_file_name = bucket_folder + "/" + file_name
            logging.debug("Uploading file: " + source_filename + " to location: " + bucket_name + "/" + destination_file_name)
            upload_blob_skinny(bucket, source_filename, destination_file_name)


if __name__ == "__main__":
    upload_dir_to_bucket("/tmp/download_urls",
                         "landing-008",
                         "",  # empty "path", put files right in the "base"
                         "wi-dpi-010",
                         "/home/jeremyfbuss/wi-dpi-analysis/.gcp/API_Data_Storage_Service_Account.json")

from google.cloud import storage
import zipfile
import logging
from google.oauth2 import service_account

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)

# storage_client = storage.Client()


def unzip_file(bucket_name, source_file, target_file):
    """Unzip file from GCS and save in GCS"""
    bucket = storage_client.get_bucket(bucket_name)
    source_blob = bucket.blob(source_file)
    target_blob = bucket.blob(target_file)
    logging.debug("Unzipping file: " + source_file)

    # Probably need to do a "GET SOURCE BLOB first"
    source_string = source_blob.download_as_string()
    zip_object = zipfile.ZipFile(source_string)
    zip_object.extractall(target_blob)
    zip_object.close()

from zipfile import ZipFile
from zipfile import is_zipfile
import io

def zip_extract(bucket_name, zip_filename_with_path):

    # storage_client = storage.Client(credentials=)
    # storage_credentials = service_account.Credentials.from_service_account_info(info)
    storage_client = storage.Client.from_service_account_json(
        '/home/jeremyfbuss/wi-dpi-analysis/.gcp/API_Data_Storage_Service_Account.json')
    bucket = storage_client.get_bucket(bucket_name)

    destination_blob_pathname = zip_filename_with_path

    blob = bucket.blob(destination_blob_pathname)
    zip_bytes = io.BytesIO(blob.download_as_string())

    if is_zipfile(zip_bytes):
        with ZipFile(zip_bytes, 'r') as myzip:
            for content_filename in myzip.namelist():
                content_file = myzip.read(content_filename)
                blob = bucket.blob(zip_filename_with_path + "/" + content_filename)
                blob.upload_from_string(content_file)

if __name__ == "__main__":
    # Add in command line?
    zip_extract("landing-008", "raw/2013.zip")  # if the file is gs://mybucket/path/file.zip
    #unzip_file("landing-008", "raw/2013.zip", "listo/2013.txt")

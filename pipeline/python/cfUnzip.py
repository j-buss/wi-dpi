from google.cloud import storage
from zipfile import ZipFile
from zipfile import is_zipfile
import logging
import io

storage_client = storage.Client()
STAGING_BUCKET = "staging-008"
logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)


def zip_extract(data, context):

    bucket = storage_client.get_bucket(data['bucket'])
    blob = bucket.blob(data['blob'])

    zip_bytes = io.BytesIO(blob.download_as_string())

    if is_zipfile(zip_bytes):
        with ZipFile(zip_bytes, 'r') as my_zip:
            new_string = my_zip.extractall()
            bucket = storage_client.get_bucket(STAGING_BUCKET)
            new_blob = bucket.blob('extract-' + data['name'])
            new_blob.upload_from_string(new_string)

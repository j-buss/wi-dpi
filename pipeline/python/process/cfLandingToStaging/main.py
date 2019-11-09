from google.cloud import storage
import os
import logging

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
logging.disable(logging.CRITICAL)
TARGET_BUCKET = "staging-008"


def landing_to_staging(data, context):

    source_bucket_name = data['bucket']
    source_blob_name = data['name']
    source_blob_basename, source_blob_ext = os.path.splitext(os.path.basename(source_blob_name))

    if source_blob_ext in [".txt", ".csv"]:
        storage_client = storage.Client()

        source_bucket = storage_client.get_bucket(source_bucket_name)
        source_blob = source_bucket.blob(source_blob_name)
        destination_bucket = storage_client.get_bucket(TARGET_BUCKET)
        new_blob_name = source_blob_name
        # copy to new destination
        new_blob = source_bucket.copy_blob(
            source_blob, destination_bucket, new_blob_name)

        print("File " + source_blob_name + " moved from " + source_bucket + " to " + destination_bucket)

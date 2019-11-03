from google.cloud import storage
import zipfile
import logging

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)

storage_client = storage.Client()


def unzip_file(bucket_name, source_file, target_file):
    """Unzip file from GCS and save in GCS"""
    bucket = storage_client.get_bucket(bucket_name)
    source_blob = bucket.blob(source_file)
    target_blob = bucket.blob(target_file)
    logging.debug("Unzipping file: " + source_file)
    # Probably need to do a "GET SOURCE BLOB first"
    zip_object = zipfile.ZipFile(source_blob)
    zip_object.extractall(target_blob)
    zip_object.close()

if __name__ == "__main__":
    # Add in command line?
    unzip_file("landing-008", "raw/2013.zip", "listo/2013.txt")

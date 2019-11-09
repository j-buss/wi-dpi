from google.cloud import storage
from zipfile import ZipFile
from zipfile import is_zipfile
import io

STAGING_BUCKET = "staging-008"


def zipextract(data, context):

    source_bucketname = data['bucket']
    zipfilename_with_path = data['name']
    storage_client = storage.Client()
    source_bucket = storage_client.get_bucket(source_bucketname)

    # Potential to use the following to change target bucket
    # target_bucket = storage_client.get_bucket(STAGING_BUCKET)
    target_bucket = source_bucket

    destination_blob_pathname = zipfilename_with_path

    source_blob = source_bucket.blob(destination_blob_pathname)
    zipbytes = io.BytesIO(source_blob.download_as_string())

    if is_zipfile(zipbytes):
        with ZipFile(zipbytes, 'r') as myzip:
            for contentfilename in myzip.namelist():
                contentfile = myzip.read(contentfilename)
                target_blob = target_bucket.blob(contentfilename)
                target_blob.upload_from_string(contentfile)
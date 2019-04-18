#import libraries
from google.cloud import storage

def set_variables(bucket_name, blob_name):
    client = storage.Client()
    # https://console.cloud.google.com/storage/browser/[bucket-id]/
    bucket = client.get_bucket(bucket_name)
    # Then do other things...
    blob = bucket.get_blob(blob_name)
    print(blob.download_as_string())

if __name__ == "__main__":
    set_variables()

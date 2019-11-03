import requests
import collections
import download_url_list
import logging
import sys
import json
import shutil
import os
import zipfile
from google.cloud import storage
from google.oauth2 import service_account

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)

def upload_blob(bucket_name, source_file_name, destination_blob_name, credentials, project_id):
    """Uploads a file to the bucket."""
    storage_client = storage.Client(project=project_id, credentials=credentials)
    bucket = storage_client.get_bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    blob.upload_from_filename(source_file_name)

    print('File {} uploaded to {}.'.format(
        source_file_name,
        destination_blob_name))


def prep_directory(directory_path):
    directory_abs_path = os.path.abspath(directory_path)
    try:
        shutil.rmtree(directory_abs_path)
    except FileNotFoundError:
        pass
    os.mkdir(directory_abs_path)


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


def download_urls(download_url_tuple):
    try:
        os.mkdir(download_url_tuple.target_directory)
    except FileExistsError:
        pass

    logging.debug(download_url_tuple.url)
    if download_url_tuple.params == "":
        res = requests.get(download_url_tuple.url)
    else:
        res = requests.get(download_url_tuple.url, params=download_url_tuple.params)

    res.raise_for_status()
    target_filename = os.path.join(download_url_tuple.target_directory, download_url_tuple.file_name)
    file_download = open(target_filename, 'wb')
    for chunk in res.iter_content(100000):
        file_download.write(chunk)
    file_download.close()


def download_url_to_gcs(input_url_blob_tuple, storage_credentials, target_directory):
    """Retrieve data from URL and store in GCP Blob"""

    # Part 1. Retrieve data from URL
    logging.debug("Inside download_url_to_gcs for:")
    logging.debug(input_url_blob_tuple)
    download_url = input_url_blob_tuple.url
    if input_url_blob_tuple.params == "":
        res = requests.get(download_url)
    else:
        res = requests.get(download_url, params=input_url_blob_tuple.params)
    res.raise_for_status()
    logging.debug("Step 1 complete. Retrieval of " + input_url_blob_tuple.url + " is successful.")

    # Part 2. Temporary save to local
    temp_file = os.path.join(target_directory, os.path.basename(input_url_blob_tuple.output_blob))
    with open(temp_file, 'wb') as f:
        for chunk in res.iter_content(100000):
            f.write(chunk)
    logging.debug("Step 2 complete. Wrote temporary file: " + temp_file)

    # Part 3. Zip files which are not currently (to improve transport)
    filename, file_extension = os.path.splitext(temp_file)
    logging.debug("Filename: " + filename)
    logging.debug("extension: " + file_extension)
    # if file_extension != ".zip":
    #    zip_file = os.path.join(target_directory, filename + ".zip")
    #    zf = zipfile.ZipFile(zip_file, 'w')
    #    zf.write(temp_file, compress_type=zipfile.ZIP_DEFLATED)
    #    temp_file = zip_file
    # else:
    #    pass

    # Part 3. Upload temporary local files to GCP Bucket
    upload_blob(input_url_blob_tuple.bucket, temp_file, input_url_blob_tuple.name, credentials,
                input_url_blob_tuple.project_id)


if __name__ == "__main__":

    url_blob_tuple = collections.namedtuple("urlBlobTuple", "name project_id bucket output_blob url params")

    file_x_list = [url_blob_tuple(name="2013",
                                  project_id="wi-dpi-010",
                                  bucket="landing-008",
                                  output_blob="raw/2013.zip",
                                  url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/13Staff.zip",
                                  params=""),
                   url_blob_tuple(name="2014",
                                  project_id="wi-dpi-010",
                                  bucket="landing-008",
                                  output_blob="raw/2014.zip",
                                  url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/14staff.zip",
                                  params=""),
                   url_blob_tuple(name="2015",
                                  project_id="wi-dpi-010",
                                  bucket="landing-008",
                                  output_blob="raw/2015.zip",
                                  url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2015rev10-31-2016.zip",
                                  params=""),
                   url_blob_tuple(name="2016",
                                  project_id="wi-dpi-010",
                                  bucket="landing-008",
                                  output_blob="raw/2016.zip",
                                  url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2016rev11-01-16.zip",
                                  params=""),
                   url_blob_tuple(name="2017",
                                  project_id="wi-dpi-010",
                                  bucket="landing-008",
                                  output_blob="raw/2017.xlsx",
                                  url="https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload",
                                  params=collections.OrderedDict([('selectedYear', 2017)])),
                   url_blob_tuple(name="2018",
                                  project_id="wi-dpi-010",
                                  bucket="landing-008",
                                  output_blob="raw/2018.xlsx",
                                  url="https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload",
                                  params=collections.OrderedDict([('selectedYear', 2018)])),
                   url_blob_tuple(name="2019",
                                  project_id="wi-dpi-010",
                                  bucket="landing-008",
                                  output_blob="raw/2019.xlsx",
                                  url="https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload",
                                  params=collections.OrderedDict([('selectedYear', 2019)]))
                   ]
    #credentials = load_credentials("/home/jeremyfbuss/wi-dpi-analysis/.gcp/API_Data_Storage_Service_Account.json")

    #temp_directory = "/tmp/download_url_to_file"
    #prep_directory(temp_directory)
    for f in download_url_list.download_url_list:
        logging.debug(f)
        download_urls(f)

import requests
import download_url_list
import logging
import shutil
import os

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
logging.disable(logging.CRITICAL)


def prep_directory(directory_path):
    directory_abs_path = os.path.abspath(directory_path)
    try:
        shutil.rmtree(directory_abs_path)
    except FileNotFoundError:
        pass
    os.mkdir(directory_abs_path)


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
    print("Downloaded file: " + target_filename)


if __name__ == "__main__":
    for f in download_url_list.download_url_list:
        logging.debug(f)
        download_urls(f)

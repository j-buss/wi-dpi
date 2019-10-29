import requests
import collections
import logging

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')


# logging.disable(logging.CRITICAL)


def get_staff_report_new():
    base_url = "https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload"

    params = collections.OrderedDict([('selectedYear', 2019)])

    req = requests.get(base_url, params=params)
    req.raise_for_status()

    # weatherData = json.loads(r.text)

    # Save the data to disk
    # fileDownload = open(os.path.join(directory, os.path.basename(comicUrl)), 'wb')
    file_download = open('test_download.xlsx', 'wb')
    for chunk in r.iter_content(100000):
        file_download.write(chunk)
    file_download.close()


def download_and_save(input_url_file_tuple):
    logging.debug(input_url_file_tuple.url)
    if input_url_file_tuple.params == "":
        res = requests.get(input_url_file_tuple.url)
    else:
        res = requests.get(input_url_file_tuple.url, params=url_file_tuple.params)

    res.raise_for_status()

    file_download = open(input_url_file_tuple.output_file, 'wb')
    for chunk in res.iter_content(100000):
        file_download.write(chunk)
    file_download.close()


if __name__ == "__main__":

    url_file_tuple = collections.namedtuple("urlFileTuple", "name output_file url params")

    file_list = [url_file_tuple(name="2013",
                                output_file="/home/jeremyfbuss/wi-dpi-analysis/data/raw/2013.zip",
                                url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/13Staff.zip",
                                params=""),
                 url_file_tuple(name="2014",
                                output_file="/home/jeremyfbuss/wi-dpi-analysis/data/raw/2014.zip",
                                url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/14staff.zip",
                                params=""),
                 url_file_tuple(name="2015",
                                output_file="/home/jeremyfbuss/wi-dpi-analysis/data/raw/2015.zip",
                                url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2015rev10-31-2016.zip",
                                params=""),
                 url_file_tuple(name="2016",
                                output_file="/home/jeremyfbuss/wi-dpi-analysis/data/raw/2016.zip",
                                url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2016rev11-01-16.zip",
                                params="")]
    for f in file_list:
        logging.debug(f)
        download_and_save(f)

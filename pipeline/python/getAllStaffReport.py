import requests
import collections
import logging

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
#logging.disable(logging.CRITICAL)

zipFileObject = collections.namedtuple("zipFileObject", "year outputfile url")

def get_staff_report_new():


    baseURL = "https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload"

    params = collections.OrderedDict([('selectedYear', 2019)])

    r = requests.get(baseURL, params=params)
    r.raise_for_status()

    #weatherData = json.loads(r.text)

    # Save the data to disk
    #fileDownload = open(os.path.join(directory, os.path.basename(comicUrl)), 'wb')
    file_download = open('test_download.xlsx', 'wb')
    for chunk in r.iter_content(100000):
        file_download.write(chunk)
    file_download.close()

def get_staff_report_zip(zipFileObject):
    fileList = [
        ('2013', '/home/jeremyfbuss/wi-dpi-analysis/data/raw/2013.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/13Staff.zip'),
        ('2014', '/home/jeremyfbuss/wi-dpi-analysis/data/raw/2014.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/14staff.zip'),
        ('2015', '/home/jeremyfbuss/wi-dpi-analysis/data/raw/2015.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2015rev10-31-2016.zip'),
        ('2016', '/home/jeremyfbuss/wi-dpi-analysis/data/raw/2016.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2016rev11-01-16.zip')
    ]
    logging.debug(zipFileObject.url)

   r = requests.get(f.url)
        r.raise_for_status()

        file_download = open(f.outputfile, 'wb')
        for chunk in r.iter_content(100000):
            file_download.write(chunk)
        file_download.close()

if __name__ == "__main__":


#    zipFileObject = collections.namedtuple("zipFileObject","year outputfile url")
    zipFileList = []
    zipFileList.append(zipFileObject(year="2013",
                                     outputfile="/home/jeremyfbuss/wi-dpi-analysis/data/raw/2013.zip",
                                     url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/13Staff.zip"))
    for f in zipFileList:
        logging.debug(f)
       # get_staff_report_zip(f)
   #get_staff_report_new()

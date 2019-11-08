import collections

download_url_tuple = collections.namedtuple("downloadURLTuple", "file_name url params target_directory")

download_url_list = [
    download_url_tuple(file_name="2013.zip",
                       url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/13Staff.zip",
                       params="",
                       target_directory="/tmp/download_urls"
                       ),
    download_url_tuple(file_name="2014.zip",
                       url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/14staff.zip",
                       params="",
                       target_directory="/tmp/download_urls"
                       ),
    download_url_tuple(file_name="2015.zip",
                       url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2015rev10-31-2016.zip",
                       params="",
                       target_directory="/tmp/download_urls"
                       ),
    download_url_tuple(file_name="2016.zip",
                       url="https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2016rev11-01-16.zip",
                       params="",
                       target_directory="/tmp/download_urls"
                       ),
    download_url_tuple(file_name="2017.xlsx",
                       url="https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload",
                       params=collections.OrderedDict([('selectedYear', 2017)]),
                       target_directory="/tmp/download_urls"
                       ),
    download_url_tuple(file_name="2018.xlsx",
                       url="https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload",
                       params=collections.OrderedDict([('selectedYear', 2018)]),
                       target_directory="/tmp/download_urls"
                       ),
    download_url_tuple(file_name="2019.xlsx",
                       url="https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload",
                       params=collections.OrderedDict([('selectedYear', 2019)]),
                       target_directory="/tmp/download_urls"
                       )
]

import requests


def downloadallstaffreport(schoolyear):

    baseURL = "https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload"
    ?selectedYear=2019&hiringLea=&workingLea=&position=&assignmentArea=&licenseType=&firstNameContains=&lastNameContains=&criteria=Filter%20Criteria:%20Selected%20Year:%202018%20-%202019;%20Selected%20Hiring%20Agencies:%20none;%20Selected%20Working%20Agencies:%20none;%20Selected%20Assignment%20Position:%20--%20All%20Positions%20--;%20Selected%20Assignment%20Area:%20--%20All%20Areas%20--;%20Selected%20First%20Name:%20none;%20Selected%20Last%20Name:%20none;%20Selected%20License%20Type:%20--%20All%20License%20Types%20--
    req = requests.get()


if __name__ == "__main__":
   downloadallstaffreport()

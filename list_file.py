from google.cloud import storage
client = storage.Client()
# https://console.cloud.google.com/storage/browser/[bucket-id]/
bucket = client.get_bucket('landing-009')
# Then do other things...
blob = bucket.get_blob('all_staff_report/2017_2018/AllStaffReportPublic__04152019_194414.csv')
print(blob.download_as_string())

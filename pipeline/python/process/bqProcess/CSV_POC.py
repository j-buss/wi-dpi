from google.cloud import bigquery
from google.cloud import storage

import pandas as pd

project_id = 'wi-dpi-010'
bucket_name = 'landing-008'

dataset_name = 'test_staging'

bq_client = bigquery.Client(project=project_id)
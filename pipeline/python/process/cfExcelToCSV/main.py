from google.cloud import storage
import pandas as pd
import gcsfs
import os
import logging

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
logging.disable(logging.CRITICAL)


def excel_to_csv(data, context):
    # Config
    source_bucket_name = data['bucket']
    source_blob_name = data['name']
    source_blob_basename, source_blob_ext = os.path.splitext(os.path.basename(source_blob_name))
    project_id = os.environ.get('GCP_PROJECT')

    if source_blob_ext == ".xlsx":
        print("Converting workbook: " + source_blob_name)

        logging.debug(source_blob_name)
        fs = gcsfs.GCSFileSystem(project=project_id)
        with fs.open(os.path.join(source_bucket_name, source_blob_name)) as f:
            df = pd.read_excel(f)
            with fs.open(os.path.join(source_bucket_name, source_blob_basename + ".csv"), "w") as out:
                df.to_csv(out, encoding='utf-8', index=False)

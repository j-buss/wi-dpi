import gcp_utilities as gcp
import pandas as pd

import logging
logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)


if __name__ == "__main__":
    creds = gcp.load_gcp_credentials("../.gcp/API_process_data.json")
    sql = '''
    select * from `wi-dpi-010.2015.2015_BASE`
    '''
    temp_df = pd.read_gbq(sql, credentials=creds)

    print(temp_df)

import gcp_utilities as gcp
import pandas as pd
import cpi

import logging
logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)


if __name__ == "__main__":
    cpi.update()
    creds = gcp.load_gcp_credentials("../.gcp/API_process_data.json")
    sql = '''
    select * from `wi-dpi-010.2015.2015_BASE` LIMIT 100
    '''
    temp_df = pd.read_gbq(sql, credentials=creds)
    temp_df['salary_adj'] = temp_df.apply(lambda x: cpi.inflate(x.salary, 2015), axis=1)
    temp_df['benefits_adj'] = temp_df.apply(lambda x: cpi.inflate(x.benefits, 2015), axis=1)
    temp_df.to_gbq("2015.2015_BASE_Adjusted",credentials=creds)

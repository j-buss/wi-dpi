import gcp_utilities as gcp
import pandas as pd
import cpi
import sys
import json

import logging
logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 adjInflation.py CREDENTIAL_FILE_PATH CONFIGURATION_FILE_PATH")
        sys.exit(1)

    credential_file = sys.argv[1]
    configuration_file = sys.argv[2]

    cpi.update()
    creds = gcp.load_gcp_credentials(credential_file)

    with open(configuration_file) as config_file:
        data = json.load(config_file)

    for json_dict in data:
        sql = json_dict["SQL"]
        ref_year = json_dict["Reference Year"]
        target_dataset = json_dict["Target Dataset"]
        target_table = json_dict["Target Table"]
        temp_df = pd.read_gbq(sql, credentials=creds)
        temp_df['salary_nominal'] = temp_df['salary']
        temp_df['benefits_nominal'] = temp_df['benefits']
        temp_df['salary'] = temp_df.apply(lambda x: cpi.inflate(x.salary, int(ref_year)), axis=1).round(2)
        temp_df['benefits'] = temp_df.apply(lambda x: cpi.inflate(x.benefits, int(ref_year)), axis=1).round(2)
        temp_df.to_gbq(target_dataset + "." + target_table,credentials=creds, if_exists='replace')

import gcp_utilities as gcp
import pandas as pd
import cpi
import sys
import json

import logging
logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
# logging.disable(logging.CRITICAL)


if __name__ == "__main__":
    cpi.update()
    creds = gcp.load_gcp_credentials("../.gcp/API_process_data.json")
    configuration_file = sys.argv[1]

    with open(configuration_file) as config_file:
        data = json.load(config_file)

    for json_dict in data:
        sql = data["SQL"]
        ref_year = data["Reference Year"]
        target_dataset = data["Target Dataset"]
        target_table = data["Target Table"]
        temp_df = pd.read_gbq(sql, credentials=creds)
        temp_df['salary_adj'] = temp_df.apply(lambda x: cpi.inflate(x.salary, ref_year), axis=1)
        temp_df['benefits_adj'] = temp_df.apply(lambda x: cpi.inflate(x.benefits, ref_year), axis=1)
        temp_df.to_gbq(target_dataset + "." + target_table,credentials=creds)

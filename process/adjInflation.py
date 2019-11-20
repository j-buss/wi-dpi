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

    # cpi.update()
    creds = gcp.load_gcp_credentials(credential_file)

    with open(configuration_file) as config_file:
        data = json.load(config_file)

    for json_dict in data:
        # for i in data:
        sql = data["SQL"]
        print(sql)
            #ref_year = i["Reference Year"]
            #target_dataset = i["Target Dataset"]
            #target_table = i["Target Table"]
            #temp_df = pd.read_gbq(sql, credentials=creds)
            #temp_df['salary_adj'] = temp_df.apply(lambda x: cpi.inflate(x.salary, ref_year), axis=1)
            #temp_df['benefits_adj'] = temp_df.apply(lambda x: cpi.inflate(x.benefits, ref_year), axis=1)
            ##temp_df.to_gbq(target_dataset + "." + target_table,credentials=creds)

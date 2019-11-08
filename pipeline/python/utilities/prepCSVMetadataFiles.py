#! /usr/bin/python3

import os
import logging
import shutil
import csv
import sys

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
logging.disable(logging.CRITICAL)


def re_write_csv(source_file, target_file, N_rows):
    """Unpivot rows to columns. Every N rows.
    Originates from malformed text file that should be csv. Input file has 1 column.
    However it should have N. """
    source = open(source_file)

    # Target File
    target = open(target_file, 'w')
    target_writer = csv.writer(target)
    output = []


    # Copy each row...except for the first row
    for idx, line in enumerate(source):
        if idx % N_rows == 0:
            logging.debug(output)
            target_writer.writerow(output)

            logging.debug("Reset string")
            output = []
            output.append(line.replace('\n',''))
        else:
            logging.debug("Row #: " + str(idx))
            output.append(line.replace('\n',''))

    target.close()
    source.close()

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: prepCSVMetadataFiles.py SOURCE_FILE TARGET_FILE N_ROWS")
    else:
        source_file = sys.argv[1]
        target_file = sys.argv[2]
        n_rows = sys.argv[3]
        logging.debug("Command line arguments passed: ")
        logging.debug("Source File: " + source_file)
        logging.debug("Target File: " + target_file)
        re_write_csv(source_file, target_file, int(n_rows))

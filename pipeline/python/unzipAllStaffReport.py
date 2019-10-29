import logging
import zipfile
import os


def unzip_file(input_zip_file):
    exampleZip = zipfile.ZipFile(input_zip_file)
    exampleZip.extractall('test_my_zip_extract')
    exampleZip.close()


if __name__ == "__main__":
    source_directory = "/home/jeremyfbuss/wi-dpi-analysis/data/raw"
    target_directory = "/home/jeremyfbuss/wi-dpi-analysis/data/stage"

    for folder_name, sub_folders, file_names in os.walk(source_directory):
        for file_name in file_names:
            logging.debug("File: " + file_name)
            base, ext = os.path.splitext(file_name)
            if ext == "zip":
                # unzip_file(os.path.join(folder_name, file_name))
                logging.debug("Unzip successful." + file_name)

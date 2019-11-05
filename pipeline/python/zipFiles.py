import zipfile
import os
import logging

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
logging.disable(logging.CRITICAL)

target_folder = "/tmp/download_urls"

if __name__ == "__main__":
    for folder_name, sub_folders, file_names in os.walk(target_folder):
        for file in file_names:
            base, extension = os.path.splitext(file)
            full_file_name = os.path.join(folder_name, file)
            if extension != ".zip":
                zip_file = base + ".zip"
                full_zip_file = os.path.join(target_folder, zip_file)
                logging.debug("Zipping up file: " + full_file_name)
                logging.debug("Creating file: " + full_zip_file)
                with zipfile.ZipFile(full_zip_file, 'w') as zip:
                    zip.write(full_file_name, os.path.basename(full_file_name), compress_type=zipfile.ZIP_DEFLATED)
                logging.debug("Created: " + full_zip_file)
                os.unlink(full_file_name)

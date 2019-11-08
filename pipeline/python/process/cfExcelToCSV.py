# Get source blob in usable state
storage_client = storage.Client()
source_bucket = storage_client.get_bucket(source_bucketname)
source_blob = source_bucket.blob(source_blob_name)
wb = openpyxl.load_workbook(source_blob.download_as_string())

# Cycle through spreadsheet - convert one tab at a time
for sheet in wb.sheetnames:

    # For each Sheet
    print("Converting sheet: " + sheet)
    csvFileName = source_blob_basename + "_" + sheet + ".csv"
    print("Creating file: " + csvFileName)
    sourceSheet = wb.get_sheet_by_name(sheet)
    sheetMaxColumn = sourceSheet.max_column
    sheetMaxRow = sourceSheet.max_row

    # Create Target File
    targetFile = open(csvFileName, 'w')
    targetWriter = csv.writer(targetFile)

    for row in range(1, sheetMaxRow + 1):
        rowArray = []
    for column in range(1, sheetMaxColumn):
        rowArray.append(sourceSheet.cell(row=row, column=column).value)

    targetWriter.writerow(rowArray)
    target_blob = target_bucket.blob(contentfilename)
    target_blob.upload_from_string(contentfile)
targetFile.close()
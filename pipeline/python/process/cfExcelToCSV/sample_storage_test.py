import main

name = 'test'
data = {
        'objectId': name,
        'bucket': 'landing-008',
        'name': 'Test_Spreadsheet.xlsx'
}
main.excel_to_csv(data, None)

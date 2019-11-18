import main

name = 'test'
data = {
        'objectId': name,
        'bucket': 'landing-008',
        'name': 'Test_Spreadsheet.xlsx'
}
main.landing_to_staging(data, None)

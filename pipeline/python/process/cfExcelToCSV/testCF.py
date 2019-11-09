import main

name = 'test'
data = {
        'objectId': name,
        'bucket': 'landing-008',
        'name': '2016.xlsx'
}
main.excel_to_csv(data, None)

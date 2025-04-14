# itb-nim-scrapper

Scrape ITB students' nim from MS Teams Web App

What you will get:
- A NIM list of students from a specific batch year. If the student already obtained "Major NIM", you will get the Major NIM, otherwise you will get the "Faculty NIM".

## Requirements
- Dart SDK

## How to Use

### Scrape MS Teams, Output to .txt

1. Clone this repository
2. Update `Bearer <token>` with your own token
3. Update `cvid` with your own cvid
4. Select which batch (angkatan) you want to scrape. Ex: '21' for 2021
5. Run the script with `dart bin/teams_scrapper.dart`
6. The script will create a file inside `data` folder. Ex: `data/output_jurusan_22_new.txt`

### Read txt, Output to .py and .json

1. Clone this repository
2. Update file paths that you want to read and merge into Map of NIM and Name. Ex: `data/output_jurusan_22_new.txt`
3. Run the script with `dart bin/data_cleaner.dart`
4. You will get the .py and .json file inside `data` folder. Ex: `data/output_jurusan_22_new.py` and `data/output_jurusan_22_new.json`

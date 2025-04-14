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
6. The script will create a file inside `data` folder. Ex: `data/batch_2023.txt`

### Read txt, Output to .py and .json

1. Clone this repository
2. Update file paths that you want to read and merge into Map of NIM and Name. Ex: `data/batch_2022.txt` and `data/batch_2023.txt`
3. Run the script with `dart bin/data_cleaner.dart`
4. You will get the .py and .json file inside `data` folder. Ex: `data/batch_22_23.py` and `data/batch_22_23.json`

### Tips

You can get `Bearer <token>` and `cvid` from your browser's developer tools.
1. Open ITB MS Teams Web App
2. Open the Network tab
3. Search for any students
4. Select the request for searching the student.

## Tools Related
- Scraper for PDDIKTI -> [PDDIKTI-kemdikbud-API](https://github.com/hendpraz/PDDIKTI-kemdikbud-API)
- ITB NIM Finder Backend -> [nim-finder-backend](https://github.com/hendpraz/nim-finder-backend)
- ITB NIM Finder Frontend -> [nim-finder-hendpraz](https://github.com/hendpraz/nim-finder-hendpraz)

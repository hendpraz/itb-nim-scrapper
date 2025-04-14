import 'dart:convert';
import 'dart:io';

Map<String, String> readDataFromFile(String path) {
  final studentFile = File(path);
  final studentData = studentFile.readAsLinesSync();

  Map<String, String> nimNameMap = {};

  var lineNum = 0;
  var groupNum = 0;
  var suggestionNum = 0;

  var lastSuggestion = '';

  for (var line in studentData) {
    try {
      final jsonString = jsonDecode(line);

      if (jsonString['Groups'] == null) {
        print('Line: $lineNum');
        print('Groups is null');
      } else {
        final groups = jsonString['Groups'];

        for (var group in groups) {
          final suggestions = group['Suggestions'];

          for (var suggestion in suggestions) {
            lastSuggestion = suggestion.toString();

            final displayName = suggestion['DisplayName'];
            final emailAddresses = suggestion['EmailAddresses'];
            final userPrincipalName = suggestion['UserPrincipalName'];

            final savedName = displayName;

            String? savedEmail;
            List<dynamic>? emails = emailAddresses;

            if (emails?.isNotEmpty == true) {
              savedEmail = emails?.first;
            } else {
              savedEmail = userPrincipalName;
            }

            // Given 16523146@mahasiswa.itb.ac.id, we want to extract 16523146
            final savedNimArr = savedEmail?.split('@');

            if (savedNimArr?.length == 2) {
              var savedNim = savedNimArr?.first;

              // If savedName has NIM's pattern (like 16523146), then we ignore it
              if (savedName.contains(RegExp(r'\d{8}'))) {
                savedNim = null;
              }

              if (savedNim != null) {
                nimNameMap[savedNim] = savedName;
              } else {
                print('ANOMALY Name with Nim: $savedNim');
                print('Last Suggestion: $lastSuggestion');
              }
            } else {
              print('Error email: $savedEmail');
              print('Last Suggestion: $lastSuggestion\n');
            }

            suggestionNum++;
          }

          groupNum++;
        }
      }

      lineNum++;
    } catch (e) {
      print('Error: $e');
      print('Line: $lineNum');
      print('Group: $groupNum');
      print('Suggestion: $suggestionNum');

      print('Last Suggestion: $lastSuggestion');
    }
  }

  return nimNameMap;
}

void writeToJson(Map<String, String> nimNameMap, String path) async {
  final file = await File(path).create();

  await file.writeAsString(jsonEncode(nimNameMap), mode: FileMode.writeOnly);
}

void writeToPython({
  required Map<String, String> nimNameMap,
  required String path,
  required String functionName,
}) async {
  print('Writing to python file...');

  final file = await File(path).create();

  await file.writeAsString("def $functionName():\n",
      mode: FileMode.writeOnlyAppend);
  await file.writeAsString("  return [\n", mode: FileMode.writeOnlyAppend);

  for (var nim in nimNameMap.keys) {
    final nama = nimNameMap[nim];

    if (nama != null) {
      await file.writeAsString("  (\"$nim\", \"$nama\"),\n",
          mode: FileMode.writeOnlyAppend);
    } else {
      print('Error nim: $nim');
    }
  }

  await file.writeAsString("  ]\n", mode: FileMode.writeOnlyAppend);

  print('Done writing to python file');
}

void main() async {
  final nimNameMap23 = readDataFromFile('data/batch_2023.txt');
  final nimNameMap22 = readDataFromFile('data/batch_2022.txt');

  final nimNameMap = {...nimNameMap22, ...nimNameMap23};

  writeToJson(nimNameMap, 'data/batch_22_23.json');
  writeToPython(
    nimNameMap: nimNameMap,
    path: 'data/batch_22_23.py',
    functionName: "get_mahasiswa_22_23_tuples",
  );
}

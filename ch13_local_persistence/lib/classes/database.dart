import 'dart:core';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class DatabaseFileRoutines {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_persistence.json');
  }

  Future<String> readJournals() async {
    try {
      final file = await _localFile;
      if (!file.existsSync()) {
        print('File does not exist: ${file.absolute}');
        await writeJournals('{"journals":[]}');
      }

      // Read the file
      String contents = await file.readAsStringSync();
      return contents;
    } catch (e) {
      print('error readJournals: $e');
      return "";
    }
  }

  Future<File> writeJournals(String json) async {
    final file = await _localFile;

    // Write the file
    print('Database writeJournals = $json');
    return file.writeAsString(json);
  }

  // To read and parse from JSON data - databaseFromJson(jsonString);
  static Database databaseFromJson(String str) {
    final dataFromJson = json.decode(str);
    return Database.fromJson(dataFromJson);
  }

  // To save and parse to JSON data - databaseToJson(jsonString);
  static String databaseToJson(Database data) {
    final dataToJson = data.toJson();
    return json.encode(dataToJson);
  }
}

class Database {
  List<Journal> journal;

  Database({
    required this.journal
  });

  factory Database.fromJson(Map<String, dynamic> json) => Database(
    journal: List<Journal>.from(json["journals"].map((x) => Journal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "journals": List<dynamic>.from(journal.map((x) => x.toJson())),
  };
}

class Journal {
  String id;
  String date;
  String mood;
  String note;

  Journal({
    required this.id,
    required this.date,
    required this.mood,
    required this.note,
  });

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
    id: json["id"],
    date: json["date"],
    mood: json["mood"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "mood": mood,
    "note": note,
  };
}

class JournalEdit{
  String action;
  Journal journal;
  JournalEdit({
    required this.action,
    required this.journal
  });
}
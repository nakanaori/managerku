import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AccessDatabase {
  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'reminder.db';
    var todoDB = openDatabase(path, version: 1, onCreate: _createDB);
    return todoDB;
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reminder(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        details TEXT,
        date INTEGER,
        timeFrom INTEGER
        timeTo INTEGER
      )
    ''');
  }
}

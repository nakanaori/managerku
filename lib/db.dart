import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AccessDatabase {
  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'reminder1.db';
    var todoDB = openDatabase(path, version: 1, onCreate: _createDB);
    return todoDB;
  }

  void _createDB(Database db, int version) async {
    print("Masuk sini");
    await db.execute('''
      CREATE TABLE reminder(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        details TEXT,
        dateFrom INTEGER,
        dateTo INTEGER,
        hasNotification INTEGER,
        notificationTime TEXT
      )
    ''');
  }
}

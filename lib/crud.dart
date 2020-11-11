import 'db.dart';
import 'package:sqflite/sqflite.dart';

import 'reminder.dart';

class CRUD {
  AccessDatabase dbhelper = new AccessDatabase();
  Future<int> insert(Reminder input) async {
    Database db = await dbhelper.initDB();
    int count = await db.insert('reminder', input.toMap());
    return count;
  }

  Future<int> update(Reminder input) async {
    Database db = await dbhelper.initDB();
    int count = await db.update('reminder', input.toMap(),
        where: 'id = ?', whereArgs: [input.id]);
    return count;
  }

  Future<int> delete(Reminder input) async {
    Database db = await dbhelper.initDB();
    int count =
        await db.delete('reminder', where: 'id = ?', whereArgs: [input.id]);
    return count;
  }

  Future<List<Reminder>> getReminder() async {
    Database db = await dbhelper.initDB();
    List<Map<String, dynamic>> mapList =
        await db.query('reminder', orderBy: "date ASC, timeFrom ASC");
    int count = mapList.length;
    List<Reminder> res = List<Reminder>();
    for (int i = 0; i < count; i++) {
      res.add(Reminder.fromMap(mapList[i]));
    }
    return res;
  }
}

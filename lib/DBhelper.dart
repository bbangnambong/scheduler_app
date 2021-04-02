import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schedulcok/schedule.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String TableName = 'Schedule';

class DBhelper {
  DBhelper._();
  static DBhelper _db = DBhelper._();
  factory DBhelper() => _db;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MyScheduleDB.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $TableName(
            id INTEGER PRIMARY KEY,
            title TEXT,
            difficulty TEXT,
            content TEXT,
            date TEXT
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  createData(Schedule schedule) async {
    final db = await database;
    var res = await db.insert('$TableName', schedule.toMap());

    return res;
  }

  //Read
  readSchedule(int id) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $TableName WHERE id = ?', [id]);
    return res.isNotEmpty
        ? Schedule(
            id: res.first['id'],
            title: res.first['title'],
            difficulty: res.first['difficulty'],
            content: res.first['content'],
            date: res.first['date'],
          )
        : Null;
  }

  //Read All
  Future<List<Schedule>> readAllSchedule() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $TableName');
    List<Schedule> list = res.isNotEmpty
        ? res
            .map((c) => Schedule(
                id: c['id'],
                title: c['title'],
                difficulty: c['difficulty'],
                content: c['content'],
                date: c['date']))
            .toList()
        : [];

    return list;
  }

  //Delete
  deleteSchedule(int id) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName WHERE id = ?', [id]);
    return res;
  }

  //Delete All
  deleteAllSchedule() async {
    final db = await database;
    db.rawDelete('DELETE FROM $TableName');
  }

  updateDog(Schedule schedule) async {
    final db = await database;
    var res = db.rawUpdate('UPDATE $TableName SET name = ? WHERE = ?',
        [schedule.title, schedule.difficulty, schedule.content, schedule.date]);
    return res;
  }

  Future<int> getID() async {
    final db = await database;
    int highestID = 0;
    var res = await db.rawQuery('SELECT * FROM $TableName');
    List<int> ids =
        res.isNotEmpty ? res.map((c) => c['id'] as int).toList() : [];
    for (int i = 0; i < ids.length; i++) {
      if (highestID < ids[i]) highestID = ids[i];
    }
    return highestID;
  }
}

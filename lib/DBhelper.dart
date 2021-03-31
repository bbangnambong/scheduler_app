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
            title TEXT PRIMARY KEY,
            difficulty INTEGER,
            content TEXT,
            date TEXT,
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  createData(Schedule schedule) async {
    final db = await database;
    var res = await db
        .rawInsert('INSERT INTO $TableName(name) VALUES(?)', [schedule.title]);
    return res;
  }

  //Read
  readSchedule(String id) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $TableName WHERE id = ?', [id]);
    return res.isNotEmpty
        ? Schedule(
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
                  title: res.first['title'],
                  difficulty: res.first['difficulty'],
                  content: res.first['content'],
                  date: res.first['date'],
                ))
            .toList()
        : [];

    return list;
  }

  //Delete
  deleteSchedule(String id) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName WHERE id = ?', [id]);
    return res;
  }

  //Delete All
  deleteAllSchedule() async {
    final db = await database;
    db.rawDelete('DELETE FROM $TableName');
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static DbHelper _dbHelper;
  Database _database;

  String _dbName = "todo.db";
  String _tableName = "tasks";
  String _colId = "id";
  String _colTitle = "title";
  String _colIsDone = "isDone";

  DbHelper._createInstance();
  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createInstance();
    }
    ;
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDB();
    }
    return _database;
  }

  Future<Database> _initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath + _dbName);
    try {
      await Directory(dbPath).create(recursive: true);
    } catch (_) {
      throw ("DataBase Error");
    }
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(''' 
    CREATE TABLE $_tableName(
    $_colId INTEGER PRIMARY KEY, 
    $_colTitle VARCHAR(100) NOT NULL, 
    $_colIsDone BOOLEAN NOT NULL
    )
    ''');
  }

  Future<int> add(Map<String, dynamic> row) async {
    Database db = await this.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await this.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await this.database;
    var updatedRow = {
      "id": row["id"],
      "title": row["title"],
      "isDone": row["isDone"] == true ? 0 : 1
    };
    int id = row["id"];
    return await db
        .update(_tableName, updatedRow, where: "$_colId=?", whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    return await db.delete(_tableName, where: "$_colId=?", whereArgs: [id]);
  }

  Future<int> count() async {
    Database db = await this.database;
    return (await queryAll()).length;
  }
}

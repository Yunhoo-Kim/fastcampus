import 'package:kb/main.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:convert';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "kb.db";
  static const _databaseVersion = 1;
  static const table = "stock";

  static const columnId = "id";
  static const columnPrice = "price";
  static const columnName = "name";
  static const columnAmount = "amount";
  static const columnMarketCap = "marketCap";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnPrice INTEGER DEFAULT 0,
            $columnAmount String,
            $columnMarketCap String,
            $columnName String
          )
          ''');

  }
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = (await instance.database)!;
    return await db.insert(table, row);
  }

  Future<List<Stocks>> queryAllStock(int date) async {
    Database db = (await instance.database)!;
    final list =
    await db.query(table);
//     await db.query(table, where: '$columnPrice = ?', whereArgs: [date]);
    return list.map((l) {
      final w = Stocks.fromJson(json.decode(l["data"] as String));
      return w;
    }).toList();
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = (await instance.database)!;
    int? id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = (await instance.database)!;
    return await db.delete(table);
  }
}

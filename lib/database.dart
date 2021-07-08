import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "gandan.db";
  static final _databaseVersion = 6;
  static final table = "gandan";
  static final weightTable = "weight";
  static final foodTable = "food";
  static final workoutTable = "workout";
  static final waterTable = "water";

  static final columnId = "id";
  static final columnDate = "date";
  static final columnData = "data";
  static final columnDuration = "duration";
  static final columnStartTime = "startTime";
  static final columnEndTime = "endTime";
  static final columnDone = "done";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
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
            $columnDate INTEGER DEFAULT 0,
            $columnDuration INTEGER DEFAULT 0,
            $columnDone INTEGER DEFAULT 0,
            $columnStartTime INTEGER DEFAULT 0,
            $columnEndTime INTEGER DEFAULT 0,
            $columnData String
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $weightTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate INTEGER DEFAULT 0,
            $columnData String
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $foodTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate INTEGER DEFAULT 0,
            $columnData String
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $workoutTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate INTEGER DEFAULT 0,
            $columnData String
          )
          ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS $waterTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate INTEGER DEFAULT 0,
            $columnData String
          )
          ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  }

  Future migrate1To2(Database db) async {
    try {
      await db.execute('''
      ALTER TABLE $table 
      ADD $columnData String 
      ''');
    } catch (e) {}
  }


  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

//   Future<int> insertDiary(Diary gandan) async {
//     Database db = await instance.database;
//     List<Diary> _history = await queryByDate(gandan.date);
//     Diary _gandan;
//
//     if (_history.length > 0) {
//       _gandan = _history.first;
//       gandan.id = _gandan.id;
//     }
//
//     if (gandan.id == null) {
//       Map<String, dynamic> row = {
//         "done": gandan.done,
//         "duration": gandan.duration,
//         "date": gandan.date,
//         "startTime": gandan.startTime,
//         "endTime": gandan.endTime,
//         "data": gandan.toJsonString()
//       };
//       return await db.insert(table, row);
//     } else {
//       Map<String, dynamic> row = {
//         "id": gandan.id,
//         "done": gandan.done,
//         "duration": gandan.duration,
//         "date": gandan.date,
//         "startTime": gandan.startTime,
//         "endTime": gandan.endTime,
//         "data": gandan.toJsonString()
//       };
//       return await db
//           .update(table, row, where: '$columnId = ?', whereArgs: [gandan.id]);
//     }
//   }
//
//   Future<int> insertWeight(Weight weight) async {
//     Database db = await instance.database;
//
//     List<Map<String, dynamic>> _history = await db
//         .query(weightTable, where: '$columnDate = ?', whereArgs: [weight.date]);
//
//     if (_history.length > 0) {
//       final _weight = Weight.fromJson(_history.first);
//       weight.id = _weight.id;
//     }
//
//     if (weight.id == null) {
//       weight.id = generateUniqueId();
//     }
//
//     if (weight.id < 0) {
//       weight.id = -weight.id;
//
//       Map<String, dynamic> row = {
//         "id": weight.id,
//         "date": weight.date,
//         "data": weight.toJsonString()
//       };
//
//       return await db.insert(weightTable, row);
//     } else {
//       Map<String, dynamic> row = {
//         "id": weight.id,
//         "date": weight.date,
//         "data": weight.toJsonString()
//       };
//
//       return await db.update(weightTable, row,
//           where: '$columnId = ?', whereArgs: [weight.id]);
//     }
//   }
//
//   Future<List<Weight>> queryWeightByDate(int date) async {
//     Database db = await instance.database;
//     final _list =
//     await db.query(weightTable, where: '$columnDate = ?', whereArgs: [date]);
//     return _list.map((_l) {
//       final w = Weight.fromJson(json.decode(_l["data"]));
// //      w.weight = double.parse(w.weight.toStringAsFixed(1));
//
//       if(w.weight != null)
//         w.weight = double.parse(w.weight.toStringAsFixed(1));
//       else
//         w.weight = 0.0;
// //      if(w.fat != null)
// //        w.fat = double.parse(w.fat.toStringAsFixed(1));
// //      if(w.muscle != null)
// //        w.muscle = double.parse(w.muscle.toStringAsFixed(1));
//       return w;
//     }).toList();
//   }
//
//   Future<List<Weight>> queryWeightBetweenDate(int startDate, int endDate) async {
//     Database db = await instance.database;
//     List<Weight> weights = [];
//     var queries = await db.query(weightTable, where: '$columnDate >= ? and $columnDate <= ?', whereArgs: [startDate, endDate]);
//     for (var q in queries) {
//       final w = Weight.fromJson(json.decode(q["data"]));
// //      w.weight = double.parse(w.weight.toStringAsFixed(1));
//       if(w.weight != null)
//         w.weight = double.parse(w.weight.toStringAsFixed(1));
//       else
//         w.weight = 0.0;
// //      if(w.fat != null)
// //        w.fat = double.parse(w.fat.toStringAsFixed(1));
// //      if(w.muscle != null)
// //        w.muscle = double.parse(w.muscle.toStringAsFixed(1));
//       weights.add(w);
//     }
//
//     return weights;
//   }
//
//   Future<List<Weight>> queryAllWeight() async {
//     Database db = await instance.database;
//     List<Weight> weights = [];
//     var queries = await db.query(weightTable);
//     for (var q in queries) {
//       final w = Weight.fromJson(json.decode(q["data"]));
//       if(w.weight != null)
//         w.weight = double.parse(w.weight.toStringAsFixed(1));
//       else
//         w.weight = 0.0;
// //      if(w.fat != null)
// //        w.fat = double.parse(w.fat.toStringAsFixed(1));
// //      if(w.muscle != null)
// //        w.muscle = double.parse(w.muscle.toStringAsFixed(1));
//       weights.add(w);
//     }
//
//     return weights;
//   }
//
//   // All of the rows are returned as a list of maps, where each map is
//   // a key-value list of columns.
//   Future<List<Diary>> queryAllRows() async {
//     Database db = await instance.database;
//     final _list = await db.query(table);
//     return _list.map((_l) => Diary.fromJson(_l)).toList();
// //    for (var _l in _list) {
// //      final g = Diary.fromJson(_l);
// //      return await db.query(table);
//   }
//
//   Future<List<Map<String, dynamic>>> queryAllDoneRows() async {
//     Database db = await instance.database;
//     return await db.query(table, where: '$columnDone = ?', whereArgs: [1]);
//   }
//
//   Future<List<Diary>> queryAllDoneRowsLteDate(int date) async {
//     Database db = await instance.database;
//     final _list = await db.query(table, where: '$columnDone = ? and $columnDate <= ?', whereArgs: [1, date]);
//     return _list.map((_l) => Diary.fromJson(_l)).toList();
//   }
//
//   Future<List<Diary>> queryByDate(int date) async {
//     Database db = await instance.database;
//     final _list =
//     await db.query(table, where: '$columnDate = ?', whereArgs: [date]);
//     return _list.map((_l) => Diary.fromJson(_l)).toList();
//   }
//
//   Future<List<Diary>> queryDiaryBetweenDate(int startDate, int endDate) async {
//     Database db = await instance.database;
//     List<Diary> histories = [];
//     var queries = await db.query(table, where: '$columnDate >= ? and $columnDate <= ?', whereArgs: [startDate, endDate]);
//
//     for (var q in queries) {
//       final w = Diary.fromJson(q);
//       histories.add(w);
//     }
//
//     return histories;
//   }
//
//   Future<List<Diary>> queryLastDate() async {
//     Database db = await instance.database;
//
//     final _list = await db.query(table, orderBy: "-$columnDate", limit: 5);
//     return _list.map((_l) => Diary.fromJson(_l)).toList();
//   }
//
//   // All of the methods (insert, query, update, delete) can also be done using
//   // raw SQL commands. This method uses a raw query to give the row count.
//   Future<int> queryRowCount() async {
//     Database db = await instance.database;
//     return Sqflite.firstIntValue(
//         await db.rawQuery('SELECT COUNT(*) FROM $table'));
//   }
//
//   // We are assuming here that the id column in the map is set. The other
//   // column values will be used to update the row.
//   Future<int> update(Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     int id = row[columnId];
//     return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   // Deletes the row specified by the id. The number of affected rows is
//   // returned. This should be 1 as long as the row exists.
//   Future<int> delete(int id) async {
//     Database db = await instance.database;
//     return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<int> deleteAll() async {
//     Database db = await instance.database;
//     return await db.delete(table);
//   }
//
//   Future<int> deleteWeight(int id) async {
//     Database db = await instance.database;
//     return await db.delete(weightTable, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<int> deleteAllWeight() async {
//     Database db = await instance.database;
//     return await db.delete(weightTable);
//   }
//
//
//   // food
//   Future<int> insertFood(Food food) async {
//     Database db = await instance.database;
//
//     if (food.id < 0) {
//       food.id = -food.id;
//
//       Map<String, dynamic> row = {
//         "id": food.id,
//         "date": food.date,
//         "data": food.toJsonString()
//       };
//       return await db.insert(foodTable, row);
//     } else {
//       Map<String, dynamic> row = {
//         "id": food.id,
//         "date": food.date,
//         "data": food.toJsonString()
//       };
//       return await db.update(foodTable, row,
//           where: '$columnId = ?', whereArgs: [food.id]);
//     }
//   }
//   Future<List<Food>> queryFoodByDate(int date) async {
//     Database db = await instance.database;
//     List<Food> foods = [];
//     var queries = await db.query(foodTable, where: "$columnDate = ?", whereArgs: [date]);
//     for (var q in queries) {
//       foods.add(Food.fromJson(json.decode(q["data"])));
//     }
//
//     foods.sort((f1, f2) => f1.time - f2.time);
//     return foods;
//   }
//
//   Future<List<Food>> queryFoodBetweenDate(int startDate, int endDate) async {
//     Database db = await instance.database;
//     List<Food> weights = [];
//     var queries = await db.query(foodTable, where: '$columnDate >= ? and $columnDate <= ?', whereArgs: [startDate, endDate]);
//     for (var q in queries) {
//       final w = Food.fromJson(json.decode(q["data"]));
//       weights.add(w);
//     }
//     return weights;
//   }
//
//   Future<List<Food>> queryFoodGteDate(int date) async {
//     Database db = await instance.database;
//     List<Food> foods = [];
//     var queries = await db.query(foodTable, where: "$columnDate >= ?", whereArgs: [date]);
//     for (var q in queries) {
//       foods.add(Food.fromJson(json.decode(q["data"])));
//     }
//
//     return foods;
//   }
//
//   Future<List<Food>> queryAllFood() async {
//     Database db = await instance.database;
//     List<Food> foods = [];
//     var queries = await db.query(foodTable);
//     for (var q in queries) {
//       foods.add(Food.fromJson(json.decode(q["data"])));
//     }
//
//     return foods;
//   }
//
//   Future<List<Food>> queryLast30Food() async {
//     Database db = await instance.database;
//     List<Food> foods = [];
//     var queries = await db.query(foodTable, limit: 30, orderBy: "-date");
//     for (var q in queries) {
//       foods.add(Food.fromJson(json.decode(q["data"])));
//     }
//
//     return foods;
//   }
//
//   Future<int> deleteFood(int id) async {
//     Database db = await instance.database;
//     return await db
//         .delete(foodTable, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<int> deleteAllFood() async {
//     Database db = await instance.database;
//     return await db.delete(foodTable);
//   }
//
//   // workout
//   Future<int> insertWorkout(Workout workout) async {
//     Database db = await instance.database;
//
//     if (workout.id < 0) {
//       workout.id = -workout.id;
//
//       Map<String, dynamic> row = {
//         "id": workout.id,
//         "date": workout.date,
//         "data": workout.toJsonString()
//       };
//       return await db.insert(workoutTable, row);
//     } else {
//       Map<String, dynamic> row = {
//         "id": workout.id,
//         "date": workout.date,
//         "data": workout.toJsonString()
//       };
//       return await db.update(workoutTable, row,
//           where: '$columnId = ?', whereArgs: [workout.id]);
//     }
//   }
//   Future<List<Workout>> queryWorkoutByDate(int date) async {
//     Database db = await instance.database;
//     try {
//       List<Workout> ws = [];
//       var queries = await db.query(
//           workoutTable, where: "$columnDate = ?", whereArgs: [date]);
//       for (var q in queries) {
//         ws.add(Workout.fromJson(json.decode(q["data"])));
//       }
//
//       // ws.sort((f1, f2) => f1.time - f2.time);
//       return ws;
//     }catch(e){
//       return [];
//     }
//   }
//
//   Future<List<Workout>> queryWorkoutBetweenDate(int startDate, int endDate) async {
//     Database db = await instance.database;
//     List<Workout> weights = [];
//     var queries = await db.query(workoutTable, where: '$columnDate >= ? and $columnDate <= ?', whereArgs: [startDate, endDate]);
//     for (var q in queries) {
//       final w = Workout.fromJson(json.decode(q["data"]));
//       weights.add(w);
//     }
//     return weights;
//   }
//
//   Future<List<Workout>> queryAllWorkout() async {
//     Database db = await instance.database;
//     try {
//       List<Workout> ws = [];
//       var queries = await db.query(workoutTable);
//       for (var q in queries) {
//         ws.add(Workout.fromJson(json.decode(q["data"])));
//       }
//       return ws;
//     }catch(e){
//       migrate4To5(db);
//       return [];
//     }
//   }
//
//   Future<List<Workout>> queryLast30Workout() async {
//     Database db = await instance.database;
//     List<Workout> ws = [];
//     var queries = await db.query(workoutTable, limit: 30, orderBy: "-date");
//     for (var q in queries) {
//       ws.add(Workout.fromJson(json.decode(q["data"])));
//     }
//
//     return ws;
//   }
//
//   Future<int> deleteWorkout(int id) async {
//     Database db = await instance.database;
//     return await db
//         .delete(workoutTable, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<int> deleteAllWorkout() async {
//     Database db = await instance.database;
//     return await db.delete(workoutTable);
//   }
//
//   Future<int> insertWater(Water water) async {
//     Database db = await instance.database;
//
//     List<Map<String, dynamic>> _history = await db
//         .query(waterTable, where: '$columnDate = ?', whereArgs: [water.date]);
//
//     if (_history.length > 0) {
//       final _water = Water.fromJson(_history.first);
//       water.id = _water.id;
//     }
//
//     if (water.id == null) {
//       water.id = generateUniqueId();
//     }
//
//     if (water.id < 0) {
//       water.id = -water.id;
//
//       Map<String, dynamic> row = {
//         "id": water.id,
//         "date": water.date,
//         "data": water.toJsonString()
//       };
//
//       return await db.insert(waterTable, row);
//     } else {
//       Map<String, dynamic> row = {
//         "id": water.id,
//         "date": water.date,
//         "data": water.toJsonString()
//       };
//
//       return await db.update(waterTable, row,
//           where: '$columnId = ?', whereArgs: [water.id]);
//     }
//   }
//
//   Future<List<Water>> queryWaterByDate(int date) async {
//     Database db = await instance.database;
//     final _list =
//     await db.query(waterTable, where: '$columnDate = ?', whereArgs: [date]);
//     return _list.map((_l) {
//       final w = Water.fromJson(json.decode(_l["data"]));
// //      w.weight = double.parse(w.weight.toStringAsFixed(1));
//
//       if(w.water != null)
//         w.water = double.parse(w.water.toStringAsFixed(1));
//       else
//         w.water = 0.0;
//       return w;
//     }).toList();
//   }
//
//   Future<List<Water>> queryWaterBetweenDate(int startDate, int endDate) async {
//     Database db = await instance.database;
//     List<Water> weights = [];
//     var queries = await db.query(waterTable, where: '$columnDate >= ? and $columnDate <= ?', whereArgs: [startDate, endDate]);
//     for (var q in queries) {
//       final w = Water.fromJson(json.decode(q["data"]));
// //      w.weight = double.parse(w.weight.toStringAsFixed(1));
//       if(w.water != null)
//         w.water = double.parse(w.water.toStringAsFixed(1));
//       else
//         w.water = 0.0;
//
//       weights.add(w);
//     }
//
//     return weights;
//   }
//
//   Future<List<Water>> queryAllWater() async {
//     try {
//       Database db = await instance.database;
//       List<Water> weights = [];
//       var queries = await db.query(waterTable);
//       for (var q in queries) {
//         final w = Water.fromJson(json.decode(q["data"]));
//         if (w.water != null)
//           w.water = double.parse(w.water.toStringAsFixed(1));
//         else
//           w.water = 0.0;
//         weights.add(w);
//       }
//
//       return weights;
//     }catch(e){
//       return [];
//     }
//   }
//
//
//   Future<int> deleteWater(int id) async {
//     Database db = await instance.database;
//     return await db
//         .delete(waterTable, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<int> deleteAllWater() async {
//     Database db = await instance.database;
//     return await db.delete(waterTable);
//   }
}


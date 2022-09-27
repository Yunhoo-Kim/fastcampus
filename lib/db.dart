class DatabaseHelper {
  static final _databaseName = "kb.db";
  static final _databaseVersion = 1;
  static final table = "stock";

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
            $columnDate INTEGER DEFAULT 0,
            $columnDuration INTEGER DEFAULT 0,
            $columnDone INTEGER DEFAULT 0,
            $columnStartTime INTEGER DEFAULT 0,
            $columnEndTime INTEGER DEFAULT 0,
            $columnData String
          )
          ''');
    
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
    final _list =
    await db.query(table);
//     await db.query(table, where: '$columnDate = ?', whereArgs: [date]);
    return _list.map((_l) {
      final w = Stocks.fromJson(json.decode(_l["data"] as String));
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

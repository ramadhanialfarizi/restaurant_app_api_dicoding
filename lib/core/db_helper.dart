import 'package:path/path.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/model/add_favorite_model.dart';
import 'package:sqflite/sqflite.dart';

import '../app/view/detail_pages/model/restaurant_detail_model.dart';

class DBHelper {
  static DBHelper? _databaseHelper;

  DBHelper._internal() {
    _databaseHelper = this;
  }

  factory DBHelper() => _databaseHelper ?? DBHelper._internal();

  late Database _database;
  final String _databaseName = 'favoriteList.db';
  final String _tableName = 'favorite';

  Future<Database> get database async {
    _database = await initializeDB();
    return _database;
  }

  Future<Database> initializeDB() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, _databaseName),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               restaurantID TEXT,
               pictureID TEXT,
               name TEXT,
               location TEXT,
               rating  REAL            
             )''',
        );
      },
      version: 1,
    );

    //print(db);
    return db;
  }

  Future<void> insertFavorite(AddFavorite addFavorite) async {
    final Database db = await database;
    db.insert(_tableName, addFavorite.toMap());
  }

  Future<List<AddFavorite>> getAllFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => AddFavorite.fromMap(res)).toList();
  }

  Future<void> deleteFavorites(int? id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

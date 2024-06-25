import 'package:flutter_package/flutter_package.dart';
import 'package:path/path.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static DatabaseHelper? _instance;
  String databaseName = "restaurant.db";
  final String _tableName = "favorite";

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database?> get database async {
    _database ??= await initDatabase();

    return _database;
  }

  initDatabase() async {
    try {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, databaseName);
      var db = openDatabase(
        path,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $_tableName (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXT,
              rating DOUBLE 
            )
          ''');
        },
        version: 1,
      );

      return db;
    } catch (e) {
      LogUtility.writeLog("initiate failed");
    }
  }

  Future<void> addFavorite(Restaurant param) async {
    try {
      final db = await database;
      if (db != null) {
        await db.insert(_tableName, param.toJson());
        LogUtility.writeLog("data saved");
      } else {
        LogUtility.writeLog("data failed save");
      }
    } catch (e) {
      LogUtility.writeLog(e.toString());
    }
  }

  Future<List<Restaurant>> getAllFavorite() async {
    try {
      final db = await database;
      if (db != null) {
        List<Map<String, dynamic>> result = await db.query(_tableName);

        return result.map((res) {
          return Restaurant.fromJson(res);
        }).toList();
      } else {
        LogUtility.writeLog("_database is null");
        return [];
      }
    } catch (e) {
      LogUtility.writeLog(e.toString());
      return [];
    }
  }

  Future<Restaurant> getFavoriteById(String id) async {
    try {
      final db = await database;
      if (db != null) {
        List<Map<String, dynamic>> results = await db.query(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );

        return results.map((element) => Restaurant.fromJson(element)).first;

        // if (results.isNotEmpty) {
        //   return results.first;
        // } else {
        //   return {};
        // }
      } else {
        LogUtility.writeLog("get by id failed");
        return Restaurant();
      }
    } catch (e) {
      LogUtility.writeLog(e.toString());
      return Restaurant();
    }
  }

  Future<void> deleteFavorite(String id) async {
    try {
      final db = await database;
      if (db != null) {
        db.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        LogUtility.writeLog("database is null");
      }
    } catch (e) {
      LogUtility.writeLog(e.toString());
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view_model/detail_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/model/add_favorite_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/view_model/favorite_provider.dart';
import 'package:restaurant_app_api_dicoding/core/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  DBHelper dbHelper;

  setUp(() async {
    sqfliteFfiInit();
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    //BHelper().database = db;
    return db;
  });

  // test('add favorite', () {
  //   /// ARANGE
  //   var detailProvider = DetailProvider();
  //   var favoriteList = FavoriteProvider();
  //   AddFavorite addFavorite = AddFavorite(
  //     id: 1,
  //   );

  //   /// ACT
  //   detailProvider.addFavorite(addFavorite);
  //   //favoriteList.getAllFavorite();

  //   /// ASSERT
  //   var result = favoriteList.favorite.contains(addFavorite);
  //   expect(result, true);
  // });
}

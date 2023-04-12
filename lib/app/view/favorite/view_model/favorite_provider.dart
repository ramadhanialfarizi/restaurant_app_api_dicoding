import 'package:flutter/foundation.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/model/add_favorite_model.dart';

import '../../../../core/db_helper.dart';
import '../../../../core/enum.dart';

class FavoriteProvider extends ChangeNotifier {
  List<AddFavorite> favorite = [];
  ResultState? state;
  final DBHelper dbHelper = DBHelper();

  bool isFavorite = false;

  //List<AddFavorite> get notes => _notes;

  void getAllFavorite() async {
    state = ResultState.loading;
    favorite = await dbHelper.getAllFavorites();
    notifyListeners();

    if (favorite.isEmpty) {
      state = ResultState.noData;
      notifyListeners();
    } else {
      state = ResultState.hasData;
    }
  }

  void deleteFavorite(int? id) async {
    isFavorite = !isFavorite;
    await dbHelper.deleteFavorites(id);
    getAllFavorite();
  }

  void addFavorite(AddFavorite addFavorite) async {
    isFavorite = !isFavorite;
    await dbHelper.insertFavorite(addFavorite);
    notifyListeners();
  }

  void removeFavorite(String? restaurantID) async {
    isFavorite = !isFavorite;
    await dbHelper.removeFavoriteFromDetail(restaurantID);
    notifyListeners();
  }
}

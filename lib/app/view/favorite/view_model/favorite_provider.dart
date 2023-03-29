import 'package:flutter/foundation.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/model/add_favorite_model.dart';

import '../../../../core/db_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  List<AddFavorite> favorite = [];
  final DBHelper dbHelper = DBHelper();

  //List<AddFavorite> get notes => _notes;

  void getAllFavorite() async {
    favorite = await dbHelper.getAllFavorites();
    notifyListeners();
  }

  void deleteNote(int? id) async {
    await dbHelper.deleteFavorites(id);
    getAllFavorite();
  }
}

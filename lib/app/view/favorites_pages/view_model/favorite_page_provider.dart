import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

class FavoritePageProvider extends ChangeNotifier {
  List<Restaurant> favoriteRestaurantList = [];

  ResultState? state;

  FavoritePageProvider() {
    getAllFavoriteData();
  }

  getAllFavoriteData() async {
    state = ResultState.loading;
    notifyListeners();

    if (databaseHelper != null) {
      favoriteRestaurantList = await databaseHelper!.getAllFavorite();

      if (favoriteRestaurantList.isEmpty) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }

      LogUtility.writeLog("data : ${jsonEncode(favoriteRestaurantList)}");
    } else {
      state = ResultState.error;
      notifyListeners();
    }
  }

  deleteFavorites(String id) async {
    await databaseHelper?.deleteFavorite(id);

    getAllFavoriteData();
  }
}

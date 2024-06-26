import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/model/restaurant_search_model.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

import '../../../../core/utils/constant.dart';
import '../../../source/data_source/remote_data_source.dart';

class SearchProvider extends ChangeNotifier with CacheManager {
  TextEditingController searchInputController = TextEditingController();
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  SearchRestaurantModel? searchRestaurantModel;
  ResultState? state;
  String message = '';

  Future<void> getSearchListRestaurant() async {
    state = ResultState.loading;
    notifyListeners();
    try {
      final source = await remoteDataSource
          .getRestaurantSearch(searchInputController.text);
      if (source.restaurants == null) {
        state = ResultState.noData;
        message = 'Empty Data';
        notifyListeners();
      } else {
        state = ResultState.hasData;
        searchRestaurantModel = source;
        notifyListeners();
      }
    } catch (e) {
      state = ResultState.error;
      message = 'Error --> $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }

  Future<Restaurant> getCacheDataById(String id) async {
    final favoriteSelected = await databaseHelper?.getFavoriteById(id);

    return favoriteSelected!;
  }

  gotoDetail(context, Restaurant data) {
    var restaurantID = data.id;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPages(
          restaurantID: restaurantID,
          restaurantData: data,
        ),
      ),
    ).whenComplete(
      () async {
        bool status = await getProcessStatus();

        if (status) {
          getSearchListRestaurant();
          setProcessStatus(status: false);
        }
      },
    );
  }

  favoriteHandle(Restaurant param, bool favoriteStatus) async {
    if (favoriteStatus) {
      deleteFavorites(param.id ?? "");
      // getAllData();
    } else {
      await databaseHelper?.addFavorite(param);
      // getAllData();
    }

    getSearchListRestaurant();

    setNeedRefresh(status: true);
  }

  deleteFavorites(String id) async {
    await databaseHelper?.deleteFavorite(id);
  }
}

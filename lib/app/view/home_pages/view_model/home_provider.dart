import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signin_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

import '../../../../core/utils/enum.dart';

class HomeProvider extends ChangeNotifier with CacheManager {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  RestaurantListModel? _restaurantList;
  ResultState? _state;
  String _message = '';
  String userName = "";

  String get message => _message;
  RestaurantListModel? get restoList => _restaurantList;
  ResultState? get state => _state;

  HomeProvider() {
    initData();
    getAllRestaurantList();
  }

  initData() async {
    String email = await getEmailName();

    if (email.isNotEmpty) {
      userName = email;
    }
  }

  Future<void> getAllRestaurantList() async {
    _state = ResultState.loading;
    try {
      final source = await remoteDataSource.getRestaurantList();
      notifyListeners();
      if (source!.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
        notifyListeners();
        // return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        _restaurantList = source;
        notifyListeners();
        // return _restaurantList = source;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  doRefresh() {
    getAllRestaurantList();
  }

  doLogout(context) async {
    setLoginStatus(false);
    removeData(keyType: CacheManagerKey.emailName.name);

    Navigator.of(context).pushReplacementNamed(SigninPages.routes);
  }
}

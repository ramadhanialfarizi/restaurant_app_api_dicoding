import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';

import '../../../../core/enum.dart';

class HomeProvider extends ChangeNotifier {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  RestaurantListModel? _restaurantList;
  ResultState? _state;
  String _message = '';

  String get message => _message;
  RestaurantListModel? get restoList => _restaurantList;
  ResultState? get state => _state;

  Future<void> getAllRestaurantList() async {
    try {
      final source = await remoteDataSource.getRestaurantList();
      _state = ResultState.loading;
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
}

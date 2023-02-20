import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/model/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/model/restaurant_list_model.dart';

enum ResultState { loading, noData, hasData, error }

class HomeProvider extends ChangeNotifier {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  // HomeProvider({required this.remoteDataSource}) {
  //   getAllRestaurantList();
  // }

  //List<Restaurant> resto = [];
  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantList get restoList => _restaurantList;
  ResultState get state => _state;

  Future<dynamic> getAllRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final source = await remoteDataSource.getRestaurantList();
      if (source.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = source;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

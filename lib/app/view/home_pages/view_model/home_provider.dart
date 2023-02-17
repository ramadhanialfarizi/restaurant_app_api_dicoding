import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/model/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/model/restaurant_list_model.dart';

//enum ResultState { loading, noData, hasData, error }

class HomeProvider extends ChangeNotifier {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  // HomeProvider({required this.remoteDataSource}) {
  //   getAllRestaurantList();
  // }

  List<Restaurant> resto = [];

  RestaurantList? _restaurantList;
  //late ResultState _state;

  RestaurantList? get restoList => _restaurantList;
  //ResultState get state => _state;

  Future<void> getAllRestaurantList() async {
    try {
      final source = await remoteDataSource.getRestaurantList();
      resto = source.restaurants.toList();
      notifyListeners();
      //return _restaurantList = source;
    } catch (e) {
      rethrow;
    }
  }
}

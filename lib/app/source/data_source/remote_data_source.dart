import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/model/restaurant_search_model.dart';

import '../../view/detail_pages/model/restaurant_detail_model.dart';

class RemoteDataSource {
  final _baseUrl = 'https://restaurant-api.dicoding.dev';
  String? query;

  Future<RestaurantListModel?> getRestaurantList() async {
    try {
      var response = await Dio().get('$_baseUrl/list');
      if (response.statusCode == 200) {
        //print(response.data);
        var result = RestaurantListModel.fromJson(response.data);
        return result;
      } else {
        throw Exception('failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantDetailModel> getDetailRestaurant(String id) async {
    try {
      var response = await Dio().get('$_baseUrl/detail/$id');
      if (response.statusCode == 200) {
        print(response.data);
        return RestaurantDetailModel.fromJson(response.data);
      } else {
        //print(response.statusMessage);
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<RestaurantSearch> getRestaurantSearch() async {
  //   var response = await Dio().get('$_baseUrl/search?q=$query');

  //   try {
  //     if (response.statusCode == 200) {
  //       return RestaurantSearch.fromJson(jsonDecode(response.data));
  //     } else {
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future userReview() async {
  //   var response = await Dio().post('$_baseUrl/review');
  // }
}

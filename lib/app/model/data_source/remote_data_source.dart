import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:restaurant_app_api_dicoding/app/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api_dicoding/app/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/model/restaurant_search_model.dart';

class RemoteDataSource {
  final _baseUrl = 'https://restaurant-api.dicoding.dev';
  String? id;
  String? query;

  RemoteDataSource({this.id, this.query});

  Future<RestaurantList> getRestaurantList() async {
    var response = await Dio().get('$_baseUrl/list');

    log(response.data);

    try {
      if (response.statusCode == 200) {
        //var data = jsonDecode(response.data)["restaurants"];
        return RestaurantList.fromJson(jsonDecode(response.data));
      } else {
        throw Exception('failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantDetail> getDetailRestaurant() async {
    var response = await Dio().get('$_baseUrl/detail/:$id');

    try {
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(jsonDecode(response.data));
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantSearch> getRestaurantSearch() async {
    var response = await Dio().get('$_baseUrl/search?q=$query');

    try {
      if (response.statusCode == 200) {
        return RestaurantSearch.fromJson(jsonDecode(response.data));
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future userReview() async {
    var response = await Dio().post('$_baseUrl/review');
  }
}

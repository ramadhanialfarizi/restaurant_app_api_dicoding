import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:restaurant_app_api_dicoding/app/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api_dicoding/app/model/restaurant_list_model.dart';

class RemoteDataSource {
  final _baseUrl = 'https://restaurant-api.dicoding.dev/';
  String? _id;

  Future<RestaurantList> getRestaurantList() async {
    var response = await Dio().get('$_baseUrl/list');

    try {
      if (response.statusCode == 200) {
        //var data = jsonDecode(response.data)["restaurants"];
        return RestaurantList.fromJson(jsonDecode(response.data));
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantDetail> getDetailRestaurant() async {
    var response = await Dio().get('$_baseUrl/detail/:$_id');

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

  Future getRestaurantSearch() async {
    //var response = await Dio().get('$_baseUrl/detail/:$_id');
  }

  Future userReview() async {}
}

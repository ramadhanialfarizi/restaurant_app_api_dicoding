import 'package:dio/dio.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/add_review_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/model/restaurant_search_model.dart';

import '../../view/detail_pages/model/restaurant_detail_model.dart';

class RemoteDataSource {
  final _baseUrl = 'https://restaurant-api.dicoding.dev';

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

  Future<RestaurantDetailModel> getDetailRestaurant(String? id) async {
    try {
      var response = await Dio().get('$_baseUrl/detail/$id');
      if (response.statusCode == 200) {
        //print(response.data);
        return RestaurantDetailModel.fromJson(response.data);
      } else {
        //print(response.statusMessage);
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchRestaurantModel> getRestaurantSearch(String? query) async {
    var response = await Dio().get('$_baseUrl/search?q=$query');

    try {
      if (response.statusCode == 200) {
        //print(response.data);
        return SearchRestaurantModel.fromJson(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AddReviewModel> addReviewUser(
      String? id, String? name, String? review) async {
    try {
      var response = await Dio().post(
        '$_baseUrl/review',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "id": id,
          "name": name,
          "review": review,
        },
      );
      //print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        //print(response.data);
        return AddReviewModel.fromJson(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      //print(e);
      rethrow;
    }
  }
}

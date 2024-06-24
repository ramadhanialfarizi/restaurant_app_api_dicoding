import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/add_review_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api_dicoding/core/utils/enum.dart';

import '../../../source/data_source/remote_data_source.dart';

class DetailProvider extends ChangeNotifier {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  RestaurantDetailModel? restaurantDetailModel;
  AddReviewModel? addReviewModel;
  ResultState? state;
  String message = '';

  Future<void> getDetailRestaurant(String? id) async {
    try {
      final source = await remoteDataSource.getDetailRestaurant(id);
      state = ResultState.loading;
      notifyListeners();
      if (source.restaurant == null) {
        state = ResultState.noData;
        message = 'Empty Data';
        notifyListeners();
      } else {
        state = ResultState.hasData;
        restaurantDetailModel = source;
        notifyListeners();
      }
    } catch (e) {
      state = ResultState.error;
      message = 'Error --> $e';
      notifyListeners();
    }
  }

  Future<void> addReview(String? id, String? name, String? review) async {
    await remoteDataSource.addReviewUser(id, name, review);
    notifyListeners();
  }
}

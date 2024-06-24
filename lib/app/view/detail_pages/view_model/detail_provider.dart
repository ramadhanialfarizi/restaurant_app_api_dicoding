import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/add_review_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';

import '../../../source/data_source/remote_data_source.dart';

class DetailProvider extends ChangeNotifier with CacheManager {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  String? userName;
  TextEditingController commentInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RestaurantDetailModel? restaurantDetailModel;
  AddReviewModel? addReviewModel;
  ResultState? state;
  String message = '';

  String restaurantID;

  @override
  void dispose() {
    commentInputController.dispose();
    super.dispose();
  }

  DetailProvider({required this.restaurantID}) {
    initData();

    if (restaurantID.isNotEmpty) {
      getDetailRestaurant(restaurantID);
    } else {
      state = ResultState.noData;
      message = 'Empty Data';
      notifyListeners();
    }
  }

  initData() async {
    userName = await getEmailName();
  }

  Future<void> getDetailRestaurant(String? id) async {
    state = ResultState.loading;
    notifyListeners();

    try {
      final source = await remoteDataSource.getDetailRestaurant(id);
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

    getDetailRestaurant(id);
    notifyListeners();
  }
}

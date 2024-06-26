import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/add_review_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

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
  bool isFavorite = false;

  String restaurantID;
  Restaurant? restaurantData;

  @override
  void dispose() {
    commentInputController.dispose();
    super.dispose();
  }

  DetailProvider({required this.restaurantID, this.restaurantData}) {
    initData();

    if (restaurantID.isNotEmpty) {
      initDetailData();
    } else {
      state = ResultState.noData;
      message = 'Empty Data';
      notifyListeners();
    }
  }

  initData() async {
    userName = await getEmailName();
  }

  initDetailData() async {
    await getDetailRestaurant(restaurantID);
    var localData = await getCacheDataById(restaurantID);

    if (restaurantID == localData.id) {
      isFavorite = true;
      notifyListeners();
    } else {
      isFavorite = false;
      notifyListeners();
    }
  }

  Future<Restaurant> getCacheDataById(String id) async {
    final favoriteSelected = await databaseHelper?.getFavoriteById(id);

    return favoriteSelected!;
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

  handleFavoriteButton() async {
    if (isFavorite) {
      deleteFavorites(restaurantID);
      isFavorite = false;
      notifyListeners();
    } else {
      await databaseHelper?.addFavorite(restaurantData ?? Restaurant());
      isFavorite = true;
      notifyListeners();
    }

    setProcessStatus(status: true);
    setNeedRefresh(status: true);
  }

  deleteFavorites(String id) async {
    await databaseHelper?.deleteFavorite(id);
  }
}

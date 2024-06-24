import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/model/restaurant_search_model.dart';

import '../../../../core/utils/constant.dart';
import '../../../source/data_source/remote_data_source.dart';

class SearchProvider extends ChangeNotifier {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  SearchRestaurantModel? searchRestaurantModel;
  ResultState? state;
  String message = '';

  Future<void> getSearchListRestaurant(String? query) async {
    try {
      final source = await remoteDataSource.getRestaurantSearch(query);
      state = ResultState.loading;
      notifyListeners();
      if (source.restaurants == null) {
        state = ResultState.noData;
        message = 'Empty Data';
        notifyListeners();
      } else {
        state = ResultState.hasData;
        searchRestaurantModel = source;
        notifyListeners();
      }
    } catch (e) {
      state = ResultState.error;
      message = 'Error --> $e';
      notifyListeners();
    }
  }
}

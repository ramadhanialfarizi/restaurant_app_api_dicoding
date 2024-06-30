import 'package:flutter/material.dart';

import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signin_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/authlogout_response_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/view/search_pages.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/logger_utility.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/warning_popup.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/authentication_helpers/auth_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/notification_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

import '../../../../core/utils/constant.dart';

class HomeProvider extends ChangeNotifier with CacheManager {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  BuildContext? context;

  RestaurantListModel? _restaurantList;
  ResultState? _state;
  ResultState? loadingNameState;
  String _message = '';
  String userName = "";
  String screenKey = ScreenKey.homeScreen.name;

  String get message => _message;
  RestaurantListModel? get restoList => _restaurantList;
  ResultState? get state => _state;

  bool isFavorite = false;

  List<Restaurant> listRestaurantLocal = [];

  // FOR NOTIFICATION
  final NotificationHelpers _notificationHelper = NotificationHelpers();

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  HomeProvider({this.context}) {
    initData();
    // _notificationHelper.configureSelectNotificationSubject(
    //     DetailPages.routes, context);
    initNotifNavigate();
  }

  initNotifNavigate() async {
    int indexNotif = await getNotificationIndex();
    _notificationHelper.configureSelectNotificationSubject(
        DetailPages.routes, indexNotif, context);
  }

  initData() async {
    loadingNameState = ResultState.loading;
    notifyListeners();

    String email = await getEmailName();

    LogUtility.writeLog('email: ${email}');

    if (email.isNotEmpty) {
      userName = email;
      loadingNameState = ResultState.hasData;
      notifyListeners();
    } else {
      loadingNameState = ResultState.noData;
      notifyListeners();
    }

    getAllRestaurantList();
  }

  Future<Restaurant> getCacheDataById(String id) async {
    final favoriteSelected = await databaseHelper?.getFavoriteById(id);

    return favoriteSelected!;
  }

  Future<void> getAllRestaurantList() async {
    _state = ResultState.loading;
    notifyListeners();

    try {
      final source = await remoteDataSource.getRestaurantList();
      notifyListeners();
      if ((source!.restaurants ?? []).isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
        notifyListeners();
        // return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        _restaurantList = source;
        notifyListeners();
        // return _restaurantList = source;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  doRefresh() {
    getAllRestaurantList();
  }

  doLogout(context) async {
    AuthlogoutResponseModel responseModel = await AuthHelpers().logout();

    if (responseModel.isError == false) {
      setLoginStatus(false);
      removeData(keyType: CacheManagerKey.emailName.name);

      Navigator.of(context).pushReplacementNamed(SigninPages.routes);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WarningDialog(
            message: responseModel.errorMsg,
          );
        },
      );
    }
  }

  favoriteHandle(Restaurant param, bool favoriteStatus) async {
    if (favoriteStatus) {
      deleteFavorites(param.id ?? "");
      // getAllData();
    } else {
      await databaseHelper?.addFavorite(param);
      // getAllData();
    }

    getAllRestaurantList();
  }

  deleteFavorites(String id) async {
    await databaseHelper?.deleteFavorite(id);
  }

  checkComparison(Restaurant param) async {
    return await getCacheDataById(param.id ?? "");
  }

  gotoFavorite(context) {
    if (screenKey != ScreenKey.favoriteScreen.name) {
      screenKey = ScreenKey.favoriteScreen.name;
      notifyListeners();

      Navigator.pop(context);
    }
  }

  gotoHome(context) {
    if (screenKey != ScreenKey.homeScreen.name) {
      screenKey = ScreenKey.homeScreen.name;
      notifyListeners();

      Navigator.pop(context);
    }
  }

  gotoSettings(context) {
    if (screenKey != ScreenKey.settingsScreen.name) {
      screenKey = ScreenKey.settingsScreen.name;
      notifyListeners();

      Navigator.pop(context);
    }
  }

  gotoDetail(context, Restaurant data) {
    var restaurantID = data.id;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPages(
          restaurantID: restaurantID,
          restaurantData: data,
        ),
      ),
    ).whenComplete(
      () async {
        bool status = await getProcessStatus();

        if (status) {
          getAllRestaurantList();
          setProcessStatus(status: false);
        }
        setNeedRefresh(status: false);
      },
    );
  }

  gotoSearch(context) {
    Navigator.pushNamed(context, SearchPages.routes).whenComplete(
      () async {
        bool needRefresh = await getNeedRefresh();

        if (needRefresh) {
          getAllRestaurantList();
          setNeedRefresh(status: false);
        }
      },
    );
  }
}

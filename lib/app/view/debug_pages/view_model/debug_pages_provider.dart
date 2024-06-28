import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/warning_popup.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/background_process_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/notification_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

class DebugPagesProvider extends ChangeNotifier with CacheManager {
  testPushNotif(context) async {
    try {
      final NotificationHelpers notificationHelper = NotificationHelpers();
      var result = await RemoteDataSource().getRestaurantList();
      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, result ?? RestaurantListModel());
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WarningDialog(
            message: e.toString(),
          );
        },
      );
    }
  }
}

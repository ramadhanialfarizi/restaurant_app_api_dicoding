import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/warning_popup.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/date_time_helper/date_time_helper.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/background_process_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';

class SettingsPageProvider extends ChangeNotifier with CacheManager {
  bool notificationActive = false;

  BuildContext context;

  SettingsPageProvider({required this.context}) {
    initData();
  }

  void initData() async {
    if (Platform.isAndroid) {
      notificationActive = await getNotificationStatus();
      notifyListeners();
      setNotificationSettings(notificationActive);
    }
  }

  doActiveNotification(bool status) {
    if (Platform.isAndroid) {
      setNotificationSettings(status);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const WarningDialog(
            message: "oops, this features not avaiable for IOS",
          );
        },
      );
    }
  }

  setNotificationSettings(bool status) async {
    notificationActive = status;
    notifyListeners();

    setNotificationStatus(status: notificationActive);
    if (notificationActive) {
      notifyListeners();
      LogUtility.writeLog("notification actived");
      // USE THIS IN PROD / DEV
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundProcessHelpers.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );

      // REMOVE THIS AFTER TESTING
      // return await AndroidAlarmManager.periodic(
      //   const Duration(milliseconds: 50),
      //   1,
      //   BackgroundProcessHelpers.callback,
      //   startAt: DateTime.now(),
      //   exact: true,
      //   wakeup: true,
      // );
    } else {
      LogUtility.writeLog("notification unactived");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

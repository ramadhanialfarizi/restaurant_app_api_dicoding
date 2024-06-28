import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_package/flutter_package.dart';
import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/notification_helpers.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundProcessHelpers {
  static BackgroundProcessHelpers? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundProcessHelpers._internal() {
    _instance = this;
  }

  factory BackgroundProcessHelpers() =>
      _instance ?? BackgroundProcessHelpers._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    LogUtility.writeLog('Alarm fired!');
    final NotificationHelpers notificationHelper = NotificationHelpers();
    var result = await RemoteDataSource().getRestaurantList();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result ?? RestaurantListModel());

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}

import 'dart:isolate';
import 'dart:ui';

import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';

import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundServices {
  static BackgroundServices? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
  // RemoteDataSource? remoteDataSource;

  BackgroundServices._internal() {
    _instance = this;
  }

  factory BackgroundServices() => _instance ?? BackgroundServices._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callBack() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = HomeProvider().restoList;

    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result!);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}

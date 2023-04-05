import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String?>();
// final didReceiveLocalNotificationSubject =
//     BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "restaurant channel";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initAndroidSettings = const AndroidInitializationSettings('app_icon');

    var initIOSSettings = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initAllSettings = InitializationSettings(
      android: initAndroidSettings,
      iOS: initIOSSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initAllSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;
        if (payload != null) {
          print('notification payload: $payload');
        }
        selectNotificationSubject.add(payload);
      },
    );
  }

  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantListModel restaurantListModel) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = 'Restaurant Update';
    var bodyNotification = restaurantListModel.restaurants[0].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      bodyNotification,
      platformChannelSpecifics,
      payload: jsonEncode(restaurantListModel.toJson()),
    );
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      var data = RestaurantListModel.fromJson(json.decode(payload!));
      var result = data.restaurants[0];
      await Navigator.pushNamed(context, route, arguments: result);
    });
  }
}

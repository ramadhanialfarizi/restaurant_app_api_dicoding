import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:rxdart/subjects.dart';

// JUST INIT ON ANDROID
final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelpers {
  static NotificationHelpers? _instance;

  NotificationHelpers._internal() {
    _instance = this;
  }

  factory NotificationHelpers() => _instance ?? NotificationHelpers._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('splash_screen_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        LogUtility.writeLog('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantListModel restaurantList) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "dicoding news channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Headline News</b>";
    var titleNews = restaurantList.restaurants?[0].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurantList.toJson()));
  }

  void configureSelectNotificationSubject(String route, context) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantListModel.fromJson(json.decode(payload));
        var restaurantData = data.restaurants?[0];
        // Navigation.intentWithData(route, article);

        Navigator.of(context).pushNamed(route, arguments: restaurantData);
      },
    );
  }
}

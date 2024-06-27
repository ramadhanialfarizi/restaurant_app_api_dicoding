import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:rxdart/subjects.dart';

// JUST INIT ON ANDROID
final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelpers {
  static NotificationHelpers? _instance;

  int randomIndex = 0;

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

  void requestAndroidPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantListModel restaurantList) async {
    try {
      var channelId = "1";
      var channelName = "channel_01";
      var channelDescription = "restaurant channel";

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

      var titleNotification = "<b>Top Recomended For You</b>";
      randomIndex = Random().nextInt((restaurantList.restaurants ?? []).length);
      var titleRestaurant = restaurantList.restaurants?[randomIndex].name;

      await flutterLocalNotificationsPlugin.show(
          0, titleNotification, titleRestaurant, platformChannelSpecifics,
          payload: json.encode(restaurantList.toJson()));
    } catch (e) {
      LogUtility.writeLog("notif error : $e");
    }
  }

  void configureSelectNotificationSubject(String route, context) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantListModel.fromJson(json.decode(payload));
        var restaurantData = data.restaurants?[randomIndex];
        // Navigation.intentWithData(route, article);

        // Navigator.of(context).pushNamed(route, arguments: restaurantData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPages(
              restaurantID: restaurantData?.id,
              restaurantData: restaurantData,
            ),
          ),
        );
      },
    );
  }
}

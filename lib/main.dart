import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/database_helper/database_helper.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/background_process_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/notification_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/utils/routes.dart';
import 'package:restaurant_app_api_dicoding/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
DatabaseHelper? databaseHelper = DatabaseHelper();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final NotificationHelpers _notificationHelper = NotificationHelpers();
  final BackgroundProcessHelpers _service = BackgroundProcessHelpers();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  _notificationHelper
      .requestAndroidPermissions(flutterLocalNotificationsPlugin);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: AppRoutes().appRoutes,
    );
  }
}

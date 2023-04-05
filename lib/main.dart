import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view_model/auth_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view_model/detail_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/view_model/favorite_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/view_model/search_provider.dart';
import 'package:restaurant_app_api_dicoding/core/background_services.dart';
import 'package:restaurant_app_api_dicoding/core/routes.dart';

import 'app/view/settings/view_model/schedule_provider.dart';
import 'core/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundServices service = BackgroundServices();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //final AppRoutes appRoutes = AppRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: AppRoutes().appRoutes,
      ),
    );
  }
}

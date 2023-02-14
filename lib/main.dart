import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/model/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:restaurant_app_api_dicoding/core/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              HomeProvider(remoteDataSource: RemoteDataSource()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRoutes appRoutes = AppRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      onGenerateRoute: appRoutes.appRoutes,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/onboarding/view/splash_screen.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/view/search_pages.dart';

import '../app/view/home_pages/view/home_pages.dart';

class AppRoutes {
  CupertinoPageRoute? appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
            builder: (_) => const SplashScreen(), settings: settings);
      case '/home':
        return CupertinoPageRoute(
            builder: (_) => const HomePages(), settings: settings);
      case '/search':
        return CupertinoPageRoute(
            builder: (_) => const SearchPages(), settings: settings);
      case '/detail':
        return CupertinoPageRoute(
            builder: (_) => const DetailPages(), settings: settings);
    }
    return null;
  }
}

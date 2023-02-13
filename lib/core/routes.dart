import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/home_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/search_pages.dart';

class AppRoutes {
  CupertinoPageRoute? appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
            builder: (_) => const HomePages(), settings: settings);
      case '/search':
        return CupertinoPageRoute(
            builder: (_) => const SearchPages(), settings: settings);
    }
    return null;
  }
}

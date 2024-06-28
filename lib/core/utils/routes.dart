import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signin_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signup_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/debug_pages/view/debug_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/onboarding/view/splash_screen.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/view/search_pages.dart';

import '../../app/view/home_pages/view/home_pages.dart';

class AppRoutes {
  CupertinoPageRoute? appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return CupertinoPageRoute(
            builder: (_) => const SplashScreen(), settings: settings);
      case SigninPages.routes:
        return CupertinoPageRoute(
            builder: (_) => const SigninPages(), settings: settings);
      case HomePages.routes:
        return CupertinoPageRoute(
            builder: (_) => const HomePages(), settings: settings);
      case SearchPages.routes:
        return CupertinoPageRoute(
            builder: (_) => const SearchPages(), settings: settings);
      case DetailPages.routes:
        return CupertinoPageRoute(
            builder: (_) => const DetailPages(), settings: settings);
      case SignupPage.routes:
        return CupertinoPageRoute(
            builder: (_) => const SignupPage(), settings: settings);
      case DebugPages.routes:
        return CupertinoPageRoute(
            builder: (context) => const DebugPages(), settings: settings);
    }
    return null;
  }
}

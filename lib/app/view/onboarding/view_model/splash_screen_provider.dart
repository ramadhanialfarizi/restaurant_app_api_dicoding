import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signin_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view/home_pages.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';

class SplashScreenProvider extends ChangeNotifier with CacheManager {
  BuildContext context;

  SplashScreenProvider({
    required this.context,
  }) {
    splashScreenStart(context);
  }

  splashScreenStart(context) async {
    bool loginStatus = await getLoginStatus();
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      if (loginStatus) {
        Navigator.of(context).pushReplacementNamed(HomePages.routes);
      } else {
        Navigator.of(context).pushReplacementNamed(SigninPages.routes);
      }
    });
  }
}

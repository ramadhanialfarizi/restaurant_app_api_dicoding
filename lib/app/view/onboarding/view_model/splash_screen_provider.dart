import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signin_page.dart';
// import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view/home_pages.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/notification_helpers/notification_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';

class SplashScreenProvider extends ChangeNotifier with CacheManager {
  BuildContext context;

  // final NotificationHelpers _notificationHelper = NotificationHelpers();

  SplashScreenProvider({
    required this.context,
  }) {
    splashScreenStart(context);

    // _notificationHelper.configureSelectNotificationSubject(
    //     DetailPages.routes, context);
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

  // @override
  // void dispose() {
  //   selectNotificationSubject.close();
  //   super.dispose();
  // }
}

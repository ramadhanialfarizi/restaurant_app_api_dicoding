import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

enum CacheManagerKey {
  loginSaveData,
  emailName,
  setProcessStatus,
  setNeedRefresh,
  notificationStatus,
}

enum ScreenKey {
  homeScreen,
  favoriteScreen,
  settingsScreen,
}

class Constant {
  static double getFullHeight(context) {
    double screenFullHeight = MediaQuery.of(context).size.height;

    return screenFullHeight;
  }

  static double getFullWidth(context) {
    double screenFullHeight = MediaQuery.of(context).size.width;

    return screenFullHeight;
  }
}

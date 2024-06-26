import 'package:flutter/material.dart';

class SettingsPageProvider extends ChangeNotifier {
  bool notificationActive = false;

  setNotificationSettings(bool status) {
    notificationActive = status;
    notifyListeners();
  }
}

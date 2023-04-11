import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_api_dicoding/core/background_services.dart';
import 'package:restaurant_app_api_dicoding/core/datetime_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleProvider extends ChangeNotifier {
  SharedPreferences? settingData;
  bool isScheduled = false;

  Future<bool> scheduledNews(bool value) async {
    settingData = await SharedPreferences.getInstance();
    isScheduled = value;
    if (isScheduled) {
      print('Scheduling Activated');
      settingData!.setBool('settingData', isScheduled);
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundServices.callBack,
        startAt: DateTimeHelper.formatTime(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Canceled');
      settingData!.remove('settingData');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

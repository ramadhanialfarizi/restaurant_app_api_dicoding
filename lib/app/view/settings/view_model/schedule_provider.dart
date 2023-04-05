import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_api_dicoding/core/background_services.dart';
import 'package:restaurant_app_api_dicoding/core/datetime_helper.dart';

class ScheduleProvider extends ChangeNotifier {
  bool isScheduled = false;

  Future<bool> scheduledNews(bool value) async {
    isScheduled = value;
    if (isScheduled) {
      print('Scheduling Activated');
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
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

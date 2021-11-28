import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:final_submission/utils/background_service.dart';
import 'package:final_submission/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Daily reminder diaktifkan');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Daily reminder dinonaktifkan');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

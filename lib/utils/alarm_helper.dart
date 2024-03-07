import 'package:alarm/model/alarm_settings.dart';
import 'package:new_app/commons/app_assets.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';

class AlarmHelper {
  ///Find next weekday in list
  static int getNextWeekdayInList(int wday, List<int> arr) {
    arr.sort();

    if (wday >= arr.last) {
      return arr.first;
    }

    int closest = arr[arr.length - 1];

    for (int num in arr) {
      if (num > wday && (num - wday) < (closest - wday)) {
        closest = num;
      }
    }

    return closest;
  }

  //Calculate the next day for the alarm
  static DateTime getNextDay(DateTime dateTime, List<int> wDays) {
    DateTime now = DateTime.now();
    if (dateTime.isAfter(now)) {
      print("after");
      if (wDays.contains(dateTime.weekday)) {
        return dateTime;
      } else {
        int nextDay = AlarmHelper.getNextWeekdayInList(dateTime.weekday, wDays);
        if (nextDay <= dateTime.weekday) {
          nextDay = nextDay + 7;
        }
        return DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day + nextDay - dateTime.weekday,
            dateTime.hour,
            dateTime.minute);
      }
    } else {
      int nextDay = AlarmHelper.getNextWeekdayInList(dateTime.weekday, wDays);
      if (nextDay <= dateTime.weekday) {
        nextDay = 7 + nextDay;
      }
      return DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day + nextDay - dateTime.weekday,
          dateTime.hour,
          dateTime.minute);
    }
  }

  static DateTime getDateTime(AlarmTime alarmTime) {
    final now = DateTime.now();
    DateTime selectDate = DateTime(
        now.year, now.month, now.day, alarmTime.hour, alarmTime.minute);
    selectDate = getNextDay(selectDate, alarmTime.dayList);
    return selectDate;
  }

  ///Create and register alarm
  static AlarmSettings buildAlarmSettings(AlarmTime alarmTime, int idKey) {
    final selectedDateTime = getDateTime(alarmTime);
    final loopAudio = true;
    final vibrate = true;
    final volume = null;
    final assetAudio = AppAssets.auAudio2;

    final alarmSettings = AlarmSettings(
      id: idKey,
      dateTime: selectedDateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volume: volume,
      assetAudioPath: assetAudio,
      notificationTitle: 'Alarm example',
      notificationBody: 'Your alarm ($idKey) is ringing',
    );
    return alarmSettings;
  }
}

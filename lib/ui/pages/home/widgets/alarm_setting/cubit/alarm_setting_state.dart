import 'package:new_app/models/interfaces/alarm_time.dart';

class AlarmSettingState {
  final AlarmTime? alarmTime;

  AlarmSettingState({this.alarmTime});

  AlarmSettingState copyWith({
    AlarmTime? alarmTime,
  }) {
    return AlarmSettingState(alarmTime: alarmTime ?? this.alarmTime);
  }
}

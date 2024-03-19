import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/cubit/alarm_setting_state.dart';

class AlarmSettingCubit extends Cubit<AlarmSettingState> {
  AlarmSettingCubit() : super(AlarmSettingState());

  void changeAlarmTime(AlarmTime alarmTime) {
    return emit(state.copyWith(alarmTime: alarmTime));
  }

  void pickWeekDay(int day) {
    List<int> array = state.alarmTime!.dayList;
    bool isDayInList = array.contains(day);

    if (!isDayInList) {
      array.add(day);
    } else {
      array.remove(day);
    }

    return emit(state.copyWith(
        alarmTime: AlarmTime(
            hour: state.alarmTime!.hour,
            minute: state.alarmTime!.minute,
            dayList: array)));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/alarm_setting_state.dart';

class AlarmSettingCubit extends Cubit<AlarmSettingState> {
  AlarmSettingCubit() : super(AlarmSettingState());

  void changeAlarmTime(AlarmTime alarmTime) {
    return emit(state.copyWith(alarmTime: alarmTime));
  }
}

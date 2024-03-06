import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:new_app/constants/constants.dart';
import 'package:new_app/models/entities/alarm_entity/alarm_entity.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/ui/pages/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final Box<AlarmEntity> alarmBox = Hive.box(alarmBoxName);
  final boxKey = 'alarm_key';

  //get data and init state
  void initHomeState() {
    AlarmEntity? alarmEntity = alarmBox.get(boxKey);
    if (alarmEntity != null) {
      return emit(HomeState(
          checkInOpen: alarmEntity.checkInOpen,
          checkOutOpen: alarmEntity.checkOutOpen,
          checkInTime: AlarmTime(
              hour: alarmEntity.checkInHour,
              minute: alarmEntity.checkInMinute,
              dayList: alarmEntity.checkInDays),
          checkOutTime: AlarmTime(
              hour: alarmEntity.checkOutHour,
              minute: alarmEntity.checkOutMinute,
              dayList: alarmEntity.checkOutDays)));
    } else
      return emit(HomeStateInitial());
  }

  //save state of checkbox for open check in time
  void changeCheckInOpen() {
    bool isOpen = state.checkInOpen ?? false;
    HomeState newHomeState = state.copyWith(checkInOpen: !isOpen);
    saveBox(newHomeState);
    return emit(newHomeState);
  }

  //save state of checkbox for open check out time
  void changeCheckOutOpen() {
    bool isOpen = state.checkOutOpen ?? false;
    HomeState newHomeState = state.copyWith(checkOutOpen: !isOpen);
    saveBox(newHomeState);
    return emit(newHomeState);
  }

  //save check_in_time
  void changeCheckInTime(int hour, int minute, List<int> dayList) {
    HomeState newHomeState = state.copyWith(
        checkInTime: AlarmTime(hour: hour, minute: minute, dayList: dayList));
    saveBox(newHomeState);
    return emit(newHomeState);
  }

  //save check_out_time
  void changeCheckOutTime(int hour, int minute, List<int> dayList) {
    HomeState newHomeState = state.copyWith(
        checkOutTime: AlarmTime(hour: hour, minute: minute, dayList: dayList));
    saveBox(newHomeState);
    return emit(newHomeState);
  }

  //save into hive box
  void saveBox(HomeState state) async {
    await alarmBox.put(
        boxKey,
        AlarmEntity(
            checkInOpen: state.checkInOpen!,
            checkOutOpen: state.checkOutOpen!,
            checkInHour: state.checkInTime!.hour,
            checkOutHour: state.checkOutTime!.hour,
            checkInMinute: state.checkInTime!.minute,
            checkOutMinute: state.checkOutTime!.minute,
            checkInDays: state.checkInTime!.dayList,
            checkOutDays: state.checkOutTime!.dayList));
  }
}

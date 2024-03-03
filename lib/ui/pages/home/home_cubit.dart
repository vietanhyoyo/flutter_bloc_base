import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/ui/pages/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void initHomeState() {
    return emit(HomeStateInitial());
  }

  void changeOpenNotification() {
    bool isOpen = state.isOpenNotification ?? false;
    return emit(state.copyWith(isOpenNotification: !isOpen));
  }

  void changeCheckInOpen() {
    bool isOpen = state.checkInOpen ?? false;
    return emit(state.copyWith(checkInOpen: !isOpen));
  }

  void changeCheckOutOpen() {
    bool isOpen = state.checkOutOpen ?? false;
    return emit(state.copyWith(checkOutOpen: !isOpen));
  }

  void changeCheckInTime(int hours, int minutes, List<int> dayList) {
    return emit(state.copyWith(
        checkInTime:
            AlarmTime(hour: hours, minute: minutes, dayList: dayList)));
  }

  void changeCheckOutTime(int hours, int minutes, List<int> dayList) {
    return emit(state.copyWith(
        checkOutTime:
            AlarmTime(hour: hours, minute: minutes, dayList: dayList)));
  }
}

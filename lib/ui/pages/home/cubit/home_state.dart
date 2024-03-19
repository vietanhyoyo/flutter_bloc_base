import 'package:new_app/models/interfaces/alarm_time.dart';

class HomeState {
  final bool? checkInOpen;
  final bool? checkOutOpen;
  final AlarmTime? checkInTime;
  final AlarmTime? checkOutTime;

  HomeState(
      {
      this.checkInOpen,
      this.checkOutOpen,
      this.checkInTime,
      this.checkOutTime});

  HomeState copyWith({
    bool? isOpenNotification,
    bool? checkInOpen,
    bool? checkOutOpen,
    AlarmTime? checkInTime,
    AlarmTime? checkOutTime,
  }) {
    return HomeState(
      checkInOpen: checkInOpen ?? this.checkInOpen,
      checkOutOpen: checkOutOpen ?? this.checkOutOpen,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
    );
  }
}

class HomeStateInitial extends HomeState {
  HomeStateInitial()
      : super(
            checkInOpen: true,
            checkOutOpen: true,
            checkInTime:
                AlarmTime(hour: 8, minute: 00, dayList: [1, 2, 3, 4, 5]),
            checkOutTime:
                AlarmTime(hour: 17, minute: 30, dayList: [1, 2, 3, 4, 5]));
}

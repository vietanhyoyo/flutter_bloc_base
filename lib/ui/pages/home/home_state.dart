import 'package:new_app/models/interfaces/alarm_time.dart';

class HomeState {
  final bool? isOpenNotification;
  final bool? checkInOpen;
  final bool? checkOutOpen;
  final AlarmTime? checkInTime;
  final AlarmTime? checkOutTime;

  HomeState(
      {this.isOpenNotification,
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
      isOpenNotification: isOpenNotification ?? this.isOpenNotification,
      checkInOpen: checkInOpen ?? this.checkInOpen,
      checkOutOpen: checkOutOpen ?? this.checkOutOpen,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
    );
  }

  List<Object> get props =>
      [isOpenNotification ?? true, checkInOpen ?? true, checkOutOpen ?? true];
}

class HomeStateInitial extends HomeState {
  HomeStateInitial()
      : super(
            isOpenNotification: true,
            checkInOpen: true,
            checkOutOpen: true,
            checkInTime: AlarmTime(hour: 7, minute: 30, dayList: [1, 2, 3]),
            checkOutTime:
                AlarmTime(hour: 18, minute: 30, dayList: [2, 3, 5]));
}

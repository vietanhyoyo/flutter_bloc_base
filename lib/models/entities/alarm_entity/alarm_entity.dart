import 'package:hive/hive.dart';

part 'alarm_entity.g.dart';

@HiveType(typeId: 0)
class AlarmEntity extends HiveObject {
  @HiveField(0, defaultValue: true)
  final bool checkInOpen;
  @HiveField(1, defaultValue: true)
  final bool checkOutOpen;
  @HiveField(2, defaultValue: 0)
  final int checkInHour;
  @HiveField(3, defaultValue: 0)
  final int checkOutHour;
  @HiveField(4, defaultValue: 0)
  final int checkInMinute;
  @HiveField(5, defaultValue: 0)
  final int checkOutMinute;
  @HiveField(6, defaultValue: [])
  final List<int> checkInDays;
  @HiveField(7, defaultValue: [])
  final List<int> checkOutDays;

  AlarmEntity({
    required this.checkInOpen,
    required this.checkOutOpen,
    required this.checkInHour,
    required this.checkOutHour,
    required this.checkInMinute,
    required this.checkOutMinute,
    required this.checkInDays,
    required this.checkOutDays,
  });
}

import 'package:hive/hive.dart';
import 'package:new_app/constants/constants.dart';
import 'package:new_app/models/entities/alarm_entity/alarm_entity.dart';

class HiveService {
  static Future<void> registerAdapter() async {
    ///Using Alarm Box
    Hive.registerAdapter<AlarmEntity>(AlarmEntityAdapter());
    await Hive.openBox<AlarmEntity>(alarmBoxName);
  }
}

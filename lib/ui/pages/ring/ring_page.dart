import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_app/commons/app_assets.dart';
import 'package:new_app/constants/constants.dart';
import 'package:new_app/models/entities/alarm_entity/alarm_entity.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/utils/alarm_helper.dart';

class RingPage extends StatelessWidget {
  final AlarmSettings alarmSettings;
  final Box<AlarmEntity> alarmBox;
  final String boxKey = 'alarm_key';

  RingPage({Key? key, required this.alarmSettings}) 
    : alarmBox = Hive.box(alarmBoxName),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Đã đến giờ chấm công!!!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Image.asset(AppAssets.gifCute),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton(context, "Nhắc lại sau 5 phút", () => remindAlarm(context)),
                buildButton(context, "Dừng", () => stopAlarm(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String label, Function() onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Future<void> remindAlarm(BuildContext context) async {
    final alarmEntity = await alarmBox.get(boxKey);
    if (alarmEntity != null) {
      final hour = alarmSettings.id == 1 ? alarmEntity.checkInHour : alarmEntity.checkOutHour;
      final minute = alarmSettings.id == 1 ? alarmEntity.checkInMinute : alarmEntity.checkOutMinute;
      final dayList = alarmSettings.id == 1 ? alarmEntity.checkInDays : alarmEntity.checkOutDays;
      await Alarm.set(
        alarmSettings: AlarmHelper.buildAlarmSettings(
          AlarmTime(
            hour: hour,
            minute: minute,
            dayList: dayList,
          ),
          alarmSettings.id,
        ),
      );
    }
    final now = DateTime.now();
    await Alarm.set(
      alarmSettings: alarmSettings.copyWith(
        id: alarmSettings.id + 3,
        dateTime: DateTime(
          now.year,
          now.month,
          now.day,
          now.hour,
          now.minute,
          0,
          0,
        ).add(const Duration(minutes: 5)),
      ),
    );
    Navigator.pop(context);
  }

  Future<void> stopAlarm(BuildContext context) async {
    await Alarm.stop(alarmSettings.id);
    final alarmEntity = await alarmBox.get(boxKey);
    if (alarmEntity != null) {
      final hour = alarmSettings.id == 1 ? alarmEntity.checkInHour : alarmEntity.checkOutHour;
      final minute = alarmSettings.id == 1 ? alarmEntity.checkInMinute : alarmEntity.checkOutMinute;
      final dayList = alarmSettings.id == 1 ? alarmEntity.checkInDays : alarmEntity.checkOutDays;
      await Alarm.set(
        alarmSettings: AlarmHelper.buildAlarmSettings(
          AlarmTime(
            hour: hour,
            minute: minute,
            dayList: dayList,
          ),
          alarmSettings.id,
        ),
      );
    }
    Navigator.pop(context);
  }
}

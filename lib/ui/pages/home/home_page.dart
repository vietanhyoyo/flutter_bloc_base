import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/alarm_example/screens/ring.dart';
import 'package:new_app/commons/app_colors.dart';
import 'package:new_app/commons/app_dimens.dart';
import 'package:new_app/commons/app_text_styte.dart';
import 'package:new_app/constants/constants.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/ui/pages/home/home_state.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/alarm_setting_cubit.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/alarm_setting_modal.dart';
import 'package:new_app/utils/helper.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeCubit;
  late List<AlarmSettings> alarms;
  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();
    if (Alarm.android) {
      checkAndroidNotificationPermission();
    }

    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
    loadAlarms();
  }

  void loadAlarms() {
    List<AlarmSettings> listAlarm = Alarm.getAlarms();
    setState(() {
      alarms = listAlarm;
      // alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });

    if (listAlarm.isEmpty) {
      // saveAlarm();
    }
  }

  AlarmSettings buildAlarmSettings() {
    final id = DateTime.now().millisecondsSinceEpoch % 10000;
    final selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
    final loopAudio = true;
    final vibrate = true;
    final volume = null;
    final assetAudio = 'assets/audio2.mp3';

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: selectedDateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volume: volume,
      assetAudioPath: assetAudio,
      notificationTitle: 'Alarm example',
      notificationBody: 'Your alarm ($id) is ringing',
    );
    return alarmSettings;
  }

  void saveAlarm() {
    Alarm.set(alarmSettings: buildAlarmSettings());
    setState(() {
      alarms = Alarm.getAlarms();
      // alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExampleAlarmRingScreen(alarmSettings: alarmSettings),
      ),
    );
    loadAlarms();
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted.',
      );
    }
  }

  void openAlarmSetting(AlarmTime time,
      Function(int hour, int minute, List<int> dayList) onSave) {
    showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius10),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.75,
            child: BlocProvider(
              create: (context) => AlarmSettingCubit(),
              child: AlarmEditModal(
                alarmTime: time,
                onSave: onSave,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.initHomeState();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.p14),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppDimens.p8),
                      child: const Text(
                        'Mở thông báo',
                        style: AppTextStyle.title,
                      ),
                    ),
                  ),
                  BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                    return Switch(
                        value: state.isOpenNotification ?? false,
                        onChanged: (value) {
                          homeCubit.changeOpenNotification();
                        });
                  })
                ],
              ),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    openAlarmSetting(
                        state.checkInTime!, homeCubit.changeCheckInTime);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: AppDimens.p14),
                          child: Row(
                            children: [
                              Expanded(child: Text("Check in")),
                              Checkbox(
                                  value: state.checkInOpen ?? true,
                                  onChanged: (value) {
                                    homeCubit.changeCheckInOpen();
                                  })
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppDimens.p14, bottom: AppDimens.p14),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                Helper.displayHour(state.checkInTime!.hour,
                                    state.checkInTime!.minute),
                                style: AppTextStyle.title,
                              )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: AppDimens.p8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        List.generate(weekDays.length, (index) {
                                      bool dayIsSelected = state
                                          .checkInTime!.dayList
                                          .contains(weekDays[index]);

                                      TextStyle style = dayIsSelected
                                          ? AppTextStyle.largePrimary
                                          : AppTextStyle.largeGrey;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppDimens.p6),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(weekDayStrings[index],
                                                style: style)),
                                      );
                                    }),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    openAlarmSetting(
                        state.checkOutTime!, homeCubit.changeCheckOutTime);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: AppDimens.p14),
                          child: Row(
                            children: [
                              Expanded(child: Text("Check out")),
                              Checkbox(
                                  value: state.checkOutOpen ?? true,
                                  onChanged: (value) {
                                    homeCubit.changeCheckOutOpen();
                                  })
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppDimens.p14, bottom: AppDimens.p14),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                Helper.displayHour(state.checkOutTime!.hour,
                                    state.checkOutTime!.minute),
                                style: AppTextStyle.title,
                              )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: AppDimens.p8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        List.generate(weekDays.length, (index) {
                                      bool dayIsSelected = state
                                          .checkOutTime!.dayList
                                          .contains(weekDays[index]);

                                      TextStyle style = dayIsSelected
                                          ? AppTextStyle.largePrimary
                                          : AppTextStyle.largeGrey;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppDimens.p6),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(weekDayStrings[index],
                                                style: style)),
                                      );
                                    }),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              for (int i = 0; i < alarms.length; i++)
                Text(TimeOfDay(
                  hour: alarms[i].dateTime.hour,
                  minute: alarms[i].dateTime.minute,
                ).format(context)),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

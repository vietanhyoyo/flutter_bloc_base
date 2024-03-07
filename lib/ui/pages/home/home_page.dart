import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/commons/app_assets.dart';
import 'package:new_app/commons/app_colors.dart';
import 'package:new_app/commons/app_dimens.dart';
import 'package:new_app/commons/app_text_styte.dart';
import 'package:new_app/constants/constants.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/ui/pages/home/home_state.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/alarm_setting_cubit.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/alarm_setting_modal.dart';
import 'package:new_app/ui/pages/ring/ring_page.dart';
import 'package:new_app/utils/alarm_helper.dart';
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
  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();
    if (Alarm.android) {
      checkAndroidNotificationPermission();
    }

    //Listening alarm ring
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void initCubit() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.initHomeState();
  }

  void saveAlarm(AlarmTime alarmTime, int idKey) {
    if (alarmTime.dayList.isEmpty) {
      return;
    }
    Alarm.set(alarmSettings: AlarmHelper.buildAlarmSettings(alarmTime, idKey));
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RingPage(alarmSettings: alarmSettings),
      ),
    );
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

  ///Edit alarm clock
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
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initCubit();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Image(
          image: AssetImage(AppAssets.logo),
          height: 180,
        ),
        toolbarHeight: 100,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.p4, vertical: AppDimens.p10),
                      child: const Text(
                        'Quản lý thông báo',
                        style: AppTextStyle.title,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppDimens.p10,
              ),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    ///On setting alarm
                    openAlarmSetting(state.checkInTime!,
                        (hour, minute, dayList) {
                      homeCubit.changeCheckInTime(hour, minute, dayList);
                      if (state.checkInOpen! == true) {
                        saveAlarm(
                            AlarmTime(
                                hour: hour, minute: minute, dayList: dayList),
                            1);
                      }
                    });
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
                                    if (value != null && value) {
                                      saveAlarm(state.checkInTime!, 1);
                                    } else {
                                      Alarm.stop(1);
                                    }
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
              SizedBox(
                height: AppDimens.p10,
              ),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    ///On setting alarm
                    openAlarmSetting(state.checkOutTime!,
                        (hour, minute, dayList) {
                      homeCubit.changeCheckOutTime(hour, minute, dayList);
                      if (state.checkOutOpen! == true) {
                        saveAlarm(
                            AlarmTime(
                                hour: hour, minute: minute, dayList: dayList),
                            2);
                      }
                    });
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
                                    if (value != null && value) {
                                      saveAlarm(state.checkOutTime!, 2);
                                    } else {
                                      Alarm.stop(2);
                                    }
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
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

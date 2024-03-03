import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/commons/app_colors.dart';
import 'package:new_app/commons/app_dimens.dart';
import 'package:new_app/commons/app_text_styte.dart';
import 'package:new_app/models/interfaces/alarm_time.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/alarm_setting_cubit.dart';
import 'package:new_app/ui/pages/home/widgets/alarm_setting/alarm_setting_state.dart';

class AlarmEditModal extends StatefulWidget {
  final AlarmTime alarmTime;
  final Function() onSave;

  const AlarmEditModal(
      {Key? key, required this.alarmTime, required this.onSave})
      : super(key: key);

  @override
  State<AlarmEditModal> createState() => _AlarmEditModalState();
}

class _AlarmEditModalState extends State<AlarmEditModal> {
  late AlarmSettingCubit alarmSettingCubit;
  final weekDays = [1, 2, 3, 4, 5, 6, 7];
  final weekDayStrings = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];

  @override
  void initState() {
    super.initState();
  }

  void initAlarmSettingCubit(BuildContext context) {
    alarmSettingCubit = BlocProvider.of<AlarmSettingCubit>(context);
    alarmSettingCubit.changeAlarmTime(widget.alarmTime);
  }

  Future<void> pickTime(AlarmSettingState state) async {
    final nowTime = DateTime.now();
    final defaultTime = DateTime(nowTime.year, nowTime.month, nowTime.day,
        widget.alarmTime.hour, widget.alarmTime.minute);
    final res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(defaultTime),
      context: context,
    );

    if (res != null) {
      alarmSettingCubit.changeAlarmTime(AlarmTime(
          hour: res.hour,
          minute: res.minute,
          dayList: state.alarmTime!.dayList));
    }

    // if (res != null) {
    //   setState(() {
    //     final DateTime now = DateTime.now();
    //     selectedDateTime = now.copyWith(
    //       hour: res.hour,
    //       minute: res.minute,
    //       second: 0,
    //       millisecond: 0,
    //       microsecond: 0,
    //     );
    //     if (selectedDateTime.isBefore(now)) {
    //       selectedDateTime = selectedDateTime.add(const Duration(days: 1));
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    initAlarmSettingCubit(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimens.p10, horizontal: AppDimens.p30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.primary),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Save",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          BlocBuilder<AlarmSettingCubit, AlarmSettingState>(
              builder: (context, state) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    pickTime(state);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.radiusMax),
                      border: Border.all(
                        color: AppColors.grey,
                        width: AppDimens.p2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.p24, vertical: AppDimens.p10),
                      child: Text(
                          "-- ${state.alarmTime!.hour}:${state.alarmTime!.minute} --",
                          style: AppTextStyle.extraLargePrimary),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppDimens.p30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(weekDays.length, (index) {
                    bool dayIsSelected =
                        state.alarmTime!.dayList.contains(weekDays[index]);

                    TextStyle style = dayIsSelected
                        ? AppTextStyle.extraWhite
                        : AppTextStyle.extra;

                    Color containerColor =
                        dayIsSelected ? AppColors.primary : AppColors.white;

                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppDimens.p6),
                      child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.radiusMax)),
                          child: Align(
                              alignment: Alignment.center,
                              child:
                                  Text(weekDayStrings[index], style: style))),
                    );
                  }),
                )
              ],
            );
          }),
          SizedBox(
            height: AppDimens.p50,
          ),
        ],
      ),
    );
  }
}

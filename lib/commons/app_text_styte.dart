import 'package:flutter/material.dart';
import 'package:new_app/commons/app_colors.dart';
import 'package:new_app/commons/app_dimens.dart';

class AppTextStyle {
  //Commons size
  static const TextStyle normal = TextStyle(fontSize: AppDimens.fontNormal);

  static const TextStyle extra = TextStyle(fontSize: AppDimens.fontExtra);

  //Special style
  static const TextStyle extraPrimary =
      TextStyle(fontSize: AppDimens.fontExtra, color: AppColors.primary);
  static const TextStyle extraWhite =
      TextStyle(fontSize: AppDimens.fontExtra, color: AppColors.white);

  static const TextStyle title = TextStyle(fontSize: AppDimens.fontExtra);

  static const TextStyle extraLargePrimary =
      TextStyle(fontSize: AppDimens.fontSuperExtra, color: AppColors.primary);
}

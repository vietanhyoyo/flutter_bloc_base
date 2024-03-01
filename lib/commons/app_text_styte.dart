import 'package:flutter/material.dart';
import 'package:new_app/commons/app_dimens.dart';
import 'package:new_app/commons/app_fonts.dart';

class AppTextStyle {
  //Commons size
  static const TextStyle normal =
      TextStyle(fontSize: AppDimens.fontNormal, fontFamily: AppFonts.roboto);

  //Special style
  static const TextStyle title =
      TextStyle(fontSize: AppDimens.fontExtra, fontFamily: AppFonts.roboto);
}

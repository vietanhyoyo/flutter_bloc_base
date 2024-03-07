import 'package:flutter/material.dart';
import 'package:new_app/commons/app_colors.dart';

class AppThemes {
  static ThemeData theme = ThemeData(
    primaryColor: AppColors.primary,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
        color: AppColors.primary,),
    checkboxTheme: CheckboxThemeData(
      overlayColor: MaterialStateColor.resolveWith((states) => AppColors.primary),
    ),
  );
}

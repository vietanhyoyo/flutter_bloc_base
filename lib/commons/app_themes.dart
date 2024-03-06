import 'package:flutter/material.dart';
import 'package:new_app/commons/app_colors.dart';

class AppThemes {
  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary, surface: AppColors.primary),
    primaryColor: AppColors.primary,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
        color: AppColors.primary,
        elevation: 0,
        surfaceTintColor: AppColors.primary),
    applyElevationOverlayColor: null,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => AppColors.primary),
    ),
  );
}

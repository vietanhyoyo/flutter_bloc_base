import 'package:flutter/material.dart';
import 'package:new_app/commons/app_colors.dart';

class AppThemes {
  static ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      primaryColor: AppColors.primary,
      useMaterial3: false,
      appBarTheme: const AppBarTheme(color: AppColors.primary));
}

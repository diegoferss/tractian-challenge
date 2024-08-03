import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.colorTheme,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.textColor,
    ),
    textTheme: TextTheme(
      titleLarge: AppFonts.nunitoSans(fontSize: 22),
      titleMedium: AppFonts.nunitoSans(fontSize: 16),
      titleSmall: AppFonts.nunitoSans(fontSize: 14),
      bodyLarge: AppFonts.nunitoSans(fontSize: 21),
      bodyMedium: AppFonts.nunitoSans(fontSize: 19),
      bodySmall: AppFonts.nunitoSans(fontSize: 17),
      headlineLarge: AppFonts.nunitoSans(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: AppFonts.nunitoSans(fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: AppFonts.nunitoSans(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}

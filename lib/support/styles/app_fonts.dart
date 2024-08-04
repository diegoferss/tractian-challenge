import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian/support/styles/app_colors.dart';

class AppFonts {
  AppFonts._();

  static TextStyle nunitoSans({
    double fontSize = 12,
    Color color = AppColors.textColor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.nunitoSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}

import 'package:evently_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeMode appTheme = ThemeMode.light;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.offWhiteBlue,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: AppColors.blue,
      secondary: AppColors.black,
      tertiary: AppColors.gray,
      onTertiary: AppColors.red,
      onPrimaryContainer: AppColors.offWhiteBlue,
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.jockeyOne(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.blue,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.overDarkBlue,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: AppColors.blue,
      secondary: AppColors.whiteGray,
      tertiary: AppColors.whiteGray,
      onTertiary: AppColors.red,
    ),
    textTheme: TextTheme(
        displaySmall: GoogleFonts.jockeyOne(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: AppColors.blue,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.blue,
        )),
  );
}

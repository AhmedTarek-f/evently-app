import 'package:evently_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.offWhiteBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        primary: AppColors.blue,
        onPrimary: AppColors.blue,
        secondary: AppColors.black,
        tertiary: AppColors.gray,
        onTertiary: AppColors.red,
        onPrimaryContainer: AppColors.offWhiteBlue,
        onSurface: AppColors.white,
        brightness: Brightness.light,
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
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.offWhiteBlue,
      ));

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.overDarkBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        primary: AppColors.blue,
        onPrimary: AppColors.whiteGray,
        secondary: AppColors.whiteGray,
        tertiary: AppColors.whiteGray,
        onTertiary: AppColors.red,
        onSurface: AppColors.white,
        brightness: Brightness.dark,
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
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteGray,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.overDarkBlue,
      ));
}

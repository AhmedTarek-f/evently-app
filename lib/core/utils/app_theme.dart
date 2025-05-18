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
      onSecondary: AppColors.black,
      tertiary: AppColors.gray,
      onTertiary: AppColors.red,
      onPrimaryContainer: AppColors.offWhiteBlue,
      onSurface: AppColors.white,
      primaryFixed: AppColors.offWhiteBlue,
      surfaceContainer: AppColors.gray,
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
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.gray,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.red,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.gray.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 22,
        color: AppColors.black2,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.offWhiteBlue,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.overDarkBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: AppColors.blue,
      onPrimary: AppColors.whiteGray,
      secondary: AppColors.whiteGray,
      onSecondary: AppColors.blue,
      tertiary: AppColors.whiteGray,
      onTertiary: AppColors.red,
      onSurface: AppColors.white,
      primaryFixed: AppColors.overDarkBlue,
      surfaceContainer: AppColors.blue,
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
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.red,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.whiteGray.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 22,
        color: AppColors.blue,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.overDarkBlue,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
  );
}

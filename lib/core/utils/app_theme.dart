import 'package:evently_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      inversePrimary: AppColors.blue,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.jockeyOne(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.blue,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        color: AppColors.gray,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: AppColors.red,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: AppColors.gray.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 22.sp,
        color: AppColors.black2,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.offWhiteBlue,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.blue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
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
      onPrimaryContainer: AppColors.whiteGray,
      surfaceContainer: AppColors.blue,
      inversePrimary: AppColors.overDarkBlue,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.jockeyOne(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.blue,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteGray,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: AppColors.red,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: AppColors.whiteGray.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 22.sp,
        color: AppColors.blue,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w700,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.overDarkBlue,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.overDarkBlue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

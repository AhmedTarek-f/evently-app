import 'package:evently_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.offWhiteBlue,
    fontFamily: "Inter",
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
      onSecondaryContainer: AppColors.offWhiteBlue,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontFamily: "Jockey One",
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.blue,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: AppColors.gray,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.red,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.gray.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        color: AppColors.black2,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 24.sp,
        color: AppColors.offWhiteBlue,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: TextStyle(
        fontSize: 24.sp,
        color: AppColors.blue,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.offWhiteBlue,
      centerTitle: true,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22.sp,
        color: AppColors.blue,
        fontWeight: FontWeight.w400,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.blue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.black,
      dialBackgroundColor: AppColors.blue,
      dialHandColor: AppColors.overDarkBlue,
      dialTextColor: AppColors.white,
      dayPeriodColor: AppColors.blue,
      dayPeriodTextColor: AppColors.white,
      entryModeIconColor: AppColors.white,
      hourMinuteColor: AppColors.blue,
      hourMinuteTextColor: AppColors.white,
      timeSelectorSeparatorColor: const WidgetStatePropertyAll(
        AppColors.white,
      ),
      helpTextStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.white),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.white),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.black,
      headerHelpStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
      headerForegroundColor: AppColors.white,
      yearForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      dayForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      todayForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      dividerColor: AppColors.blue,
      shadowColor: AppColors.blue,
      confirmButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.white),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.white),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.overDarkBlue,
    fontFamily: "Inter",
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
      onSecondaryContainer: AppColors.blue,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontFamily: "Jockey One",
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.blue,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteGray,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.red,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 14.sp,
        color: AppColors.whiteGray.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        color: AppColors.blue,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: TextStyle(
        fontSize: 24.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: TextStyle(
        fontSize: 24.sp,
        color: AppColors.blue,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.overDarkBlue,
      centerTitle: true,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22.sp,
        color: AppColors.blue,
        fontWeight: FontWeight.w400,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.overDarkBlue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.overDarkBlue,
      dialBackgroundColor: AppColors.blue,
      dialHandColor: AppColors.overDarkBlue,
      dialTextColor: AppColors.white,
      dayPeriodColor: AppColors.blue,
      dayPeriodTextColor: AppColors.whiteGray,
      entryModeIconColor: AppColors.whiteGray,
      hourMinuteColor: AppColors.blue,
      hourMinuteTextColor: AppColors.whiteGray,
      timeSelectorSeparatorColor: const WidgetStatePropertyAll(
        AppColors.overDarkBlue,
      ),
      helpTextStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w700,
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.whiteGray),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.whiteGray,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.whiteGray),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.whiteGray,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.overDarkBlue,
      headerHelpStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.whiteGray,
        fontWeight: FontWeight.w700,
      ),
      headerForegroundColor: AppColors.whiteGray,
      yearForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      dayForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      dividerColor: AppColors.blue,
      shadowColor: AppColors.blue,
      confirmButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.whiteGray),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.whiteGray,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.whiteGray),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14.sp,
            color: AppColors.whiteGray,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

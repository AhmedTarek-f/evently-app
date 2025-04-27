import 'package:evently_app/core/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      child: MaterialApp(
        title: 'Evently',
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.appTheme,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const Placeholder(),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/utils/app_theme.dart';
import 'package:evently_app/features/start/presentation/views/start_view.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:evently_app/features/start/presentation/views_model/start_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<StartCubit>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      child: BlocBuilder<StartCubit, StartState>(
        buildWhen: (previous, current) =>
            current is ChangeLanguageIndexState ||
            current is ChangeThemeIndexState,
        builder: (context, state) => MaterialApp(
          title: 'Evently',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const StartView(),
        ),
      ),
    );
  }
}

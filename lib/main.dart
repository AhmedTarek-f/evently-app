import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/cache/shared_preferences_helper.dart';
import 'package:evently_app/evently_app.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/my_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesHelper.init();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  FlutterNativeSplash.remove();
  runApp(
    BlocProvider<StartCubit>(
      create: (context) => StartCubit(),
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const EventlyApp(),
      ),
    ),
  );
}

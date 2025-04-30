import 'package:evently_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:evently_app/features/onboarding/presentation/views_model/onboarding_cubit.dart';
import 'package:evently_app/features/start/presentation/views/start_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    StartView.routeName: (_) => const StartView(),
    OnboardingView.routeName: (_) => BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(),
          child: const OnboardingView(),
        ),
  };
}

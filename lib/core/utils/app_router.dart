import 'package:evently_app/features/auth/forget_password/presentation/views/forget_password_view.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_cubit.dart';
import 'package:evently_app/features/auth/login/presentation/views/login_view.dart';
import 'package:evently_app/features/auth/login/presentation/views_model/login_cubit.dart';
import 'package:evently_app/features/auth/register/presentation/views/register_view.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_cubit.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views/verify_email_view.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views_model/verify_email_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views/create_event_view.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views/evently_bottom_navigation_view.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
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
    LoginView.routeName: (_) => BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
          child: const LoginView(),
        ),
    RegisterView.routeName: (_) => BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
          child: const RegisterView(),
        ),
    ForgetPasswordView.routeName: (_) => BlocProvider<ForgetPasswordCubit>(
          create: (context) => ForgetPasswordCubit(),
          child: const ForgetPasswordView(),
        ),
    VerifyEmailView.routeName: (_) => BlocProvider<VerifyEmailCubit>(
          create: (context) => VerifyEmailCubit(),
          child: const VerifyEmailView(),
        ),
    EventlyBottomNavigationView.routeName: (_) =>
        BlocProvider<EventlyBottomNavigationCubit>(
          create: (context) => EventlyBottomNavigationCubit(),
          child: const EventlyBottomNavigationView(),
        ),
    CreateEventView.routeName: (_) => BlocProvider<CreateEventCubit>(
          create: (context) => CreateEventCubit(),
          child: const CreateEventView(),
        )
  };
}

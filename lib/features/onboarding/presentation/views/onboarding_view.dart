import 'package:evently_app/features/onboarding/presentation/views/widgets/onboarding_app_bar.dart';
import 'package:evently_app/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const String routeName = "OnboardingView";
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: OnboardingAppBar(),
      body: OnboardingViewBody(),
    );
  }
}

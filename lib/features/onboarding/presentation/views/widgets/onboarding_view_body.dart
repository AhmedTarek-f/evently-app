import 'package:evently_app/features/onboarding/presentation/views/widgets/onboarding_page_navigation_dots.dart';
import 'package:evently_app/features/onboarding/presentation/views/widgets/onboarding_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const RPadding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Expanded(
            child: OnboardingPageView(),
          ),
          OnboardingPageNavigationDots(),
        ],
      ),
    );
  }
}

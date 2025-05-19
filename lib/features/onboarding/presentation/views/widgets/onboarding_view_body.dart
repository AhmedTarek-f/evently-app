import 'package:evently_app/features/auth/login/presentation/views/login_view.dart';
import 'package:evently_app/features/onboarding/presentation/views/widgets/onboarding_page_navigation_dots.dart';
import 'package:evently_app/features/onboarding/presentation/views/widgets/onboarding_page_view.dart';
import 'package:evently_app/features/onboarding/presentation/views_model/onboarding_cubit.dart';
import 'package:evently_app/features/onboarding/presentation/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<OnboardingCubit>(context);
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) => current is MovingToLoginScreenState,
      listener: (context, state) async {
        if (state is MovingToLoginScreenState) {
          await controller.finishedOnboardingFirstTime();
          if (context.mounted) {
            Navigator.pushReplacementNamed(
              context,
              LoginView.routeName,
            );
          }
        }
      },
      child: const RPadding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: OnboardingPageView(),
            ),
            OnboardingPageNavigationDots(),
          ],
        ),
      ),
    );
  }
}

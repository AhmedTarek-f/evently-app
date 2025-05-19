import 'package:evently_app/features/onboarding/presentation/views/widgets/onboarding_item.dart';
import 'package:evently_app/features/onboarding/presentation/views_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    final controller = BlocProvider.of<OnboardingCubit>(context);
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: controller.onBoardingPageController,
      onPageChanged: (value) =>
          controller.updateCurrentPageIndex(newIndex: value),
      itemBuilder: (context, index) => OnboardingItem(
        onboardingData: isDarkMode
            ? controller.darkOnBoardingList[index]
            : controller.lightOnBoardingList[index],
      ),
      itemCount: controller.darkOnBoardingList.length,
    );
  }
}

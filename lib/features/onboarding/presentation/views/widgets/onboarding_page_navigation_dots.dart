import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/features/onboarding/presentation/views_model/onboarding_cubit.dart';
import 'package:evently_app/features/onboarding/presentation/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageNavigationDots extends StatelessWidget {
  const OnboardingPageNavigationDots({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<OnboardingCubit>(context);
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return RPadding(
      padding: const EdgeInsets.only(bottom: 13.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<OnboardingCubit, OnboardingState>(
            buildWhen: (previous, current) =>
                current is UpdatingOnboardingPageIndex,
            builder: (context, state) => controller.currentPageIndex == 0
                ? const RSizedBox(
                    width: 37.6,
                  )
                : GestureDetector(
                    onTap: () => controller.moveToPreviousPage(),
                    child: SvgPicture.asset(
                      isDarkMode
                          ? AppIcons.darkLeftCircularArrow
                          : AppIcons.lightLeftCircularArrow,
                    ),
                  ),
          ),
          SmoothPageIndicator(
            controller: controller.onBoardingPageController,
            count: controller.lightOnBoardingList.length,
            onDotClicked: (index) =>
                controller.navigateToDotIndexPage(index: index),
            effect: ExpandingDotsEffect(
              dotWidth: 8.r,
              dotHeight: 8.r,
              radius: 36.r,
              strokeWidth: 21.w,
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
          GestureDetector(
            onTap: () => controller.moveToNextPage(),
            child: SvgPicture.asset(
              isDarkMode
                  ? AppIcons.darkRightCircularArrow
                  : AppIcons.lightRightCircularArrow,
            ),
          ),
        ],
      ),
    );
  }
}

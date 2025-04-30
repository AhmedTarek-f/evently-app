import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:evently_app/features/start/presentation/views/widgets/language_switch_row.dart';
import 'package:evently_app/features/start/presentation/views/widgets/theme_switch_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartViewBody extends StatelessWidget {
  const StartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(
            height: 28,
          ),
          Image.asset(
            isDarkMode ? AppImages.startScreenDark : AppImages.startScreenLight,
            height: 361.h,
          ),
          const RSizedBox(
            height: 28,
          ),
          Text(
            AppText.startTitle.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const RSizedBox(
            height: 28,
          ),
          Text(
            AppText.startBody.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const RSizedBox(
            height: 28,
          ),
          const LanguageSwitchRow(),
          const RSizedBox(
            height: 16,
          ),
          const ThemeSwitchRow(),
          const RSizedBox(
            height: 28,
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                OnboardingView.routeName,
              );
            },
            buttonTitle: AppText.startButton.tr(),
          )
        ],
      ),
    );
  }
}

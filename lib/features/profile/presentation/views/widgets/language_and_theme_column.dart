import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_drop_down_button_form_field.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageAndThemeColumn extends StatelessWidget {
  const LanguageAndThemeColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ProfileCubit>(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.languageCapital.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const RSizedBox(height: 16),
          CustomDropDownButtonFormField(
            dropDownItemsList: controller.languages,
            initialValue: controller.currentLanguage,
            onChanged: (language) => controller.changeLanguage(
              context: context,
              languageValue: language,
            ),
          ),
          const RSizedBox(height: 16),
          Text(
            AppText.themeCapital.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const RSizedBox(height: 16),
          CustomDropDownButtonFormField(
            dropDownItemsList: controller.theme,
            initialValue: controller.currentTheme,
            onChanged: (theme) async => await controller.changeTheme(
              context: context,
              themeValue: theme,
            ),
          ),
        ],
      ),
    );
  }
}

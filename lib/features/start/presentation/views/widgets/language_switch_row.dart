import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_toggle_switch.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:evently_app/features/start/presentation/views_model/start_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSwitchRow extends StatelessWidget {
  const LanguageSwitchRow({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<StartCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppText.language.tr(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        BlocConsumer<StartCubit, StartState>(
          buildWhen: (previous, current) => current is ChangeLanguageIndexState,
          listener: (context, state) {
            if (state is ChangeLanguageIndexState) {
              context.setLocale(Locale(state.selectedLang));
            }
          },
          builder: (context, state) => CustomToggleSwitch(
            currentIndex: controller.languageSelectedIndex,
            firstIcon: AppIcons.us,
            secondIcon: AppIcons.eg,
            onIndexChanged: (index) async =>
                await controller.onLanguageIndexChanged(index: index),
          ),
        )
      ],
    );
  }
}

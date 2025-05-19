import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_toggle_switch.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:evently_app/features/start/presentation/views_model/start_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchRow extends StatelessWidget {
  const ThemeSwitchRow({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<StartCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppText.theme.tr(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        BlocBuilder<StartCubit, StartState>(
          buildWhen: (previous, current) => current is ChangeThemeIndexState,
          builder: (context, state) => CustomToggleSwitch(
            currentIndex: controller.themeSelectedIndex,
            firstIcon: AppIcons.sun,
            secondIcon: AppIcons.moon,
            secondIconColor: ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
            onIndexChanged: (index) async =>
                await controller.onThemeIndexChanged(index: index),
          ),
        )
      ],
    );
  }
}

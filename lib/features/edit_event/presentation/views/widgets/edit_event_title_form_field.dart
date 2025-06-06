import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/validations.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditEventTitleFormField extends StatelessWidget {
  const EditEventTitleFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final editEventController = BlocProvider.of<EditEventCubit>(context);
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: editEventController.eventTitleController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
          maxWidth: 56.r,
          maxHeight: 56.r,
        ),
        contentPadding: REdgeInsets.all(16),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryFixed,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: AppText.titleHint.tr(),
        focusedBorder: buildOutlinedBorder(
          context: context,
        ),
        enabledBorder: buildOutlinedBorder(
          context: context,
        ),
        focusedErrorBorder: buildOutlinedBorder(
          borderColor: AppColors.red.withValues(
            alpha: 0.5,
          ),
          context: context,
        ),
        errorBorder: buildOutlinedBorder(
          borderColor: AppColors.red,
          context: context,
        ),
        disabledBorder: buildOutlinedBorder(
          borderColor: AppColors.gray,
          context: context,
        ),
        prefixIcon: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            AppIcons.noteEdit,
            width: 56.r,
            height: 56.r,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.tertiary,
              BlendMode.srcIn,
            ),
          ),
        ),
        errorStyle: Theme.of(context).textTheme.titleSmall,
      ),
      enabled: !editEventController.isLoading,
      maxLines: 1,
      validator: (value) => Validations.eventTitleValidation(value),
    );
  }

  OutlineInputBorder buildOutlinedBorder({
    Color? borderColor,
    required BuildContext context,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: borderColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
    );
  }
}

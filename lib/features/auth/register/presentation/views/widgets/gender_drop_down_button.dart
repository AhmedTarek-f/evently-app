import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_cubit.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderDropDownButtonField extends StatelessWidget {
  const GenderDropDownButtonField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<StartCubit>(context);
    final controller = BlocProvider.of<RegisterCubit>(context);
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      style: Theme.of(context).textTheme.bodyMedium,
      value: controller.selectedGender,
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
          maxWidth: 56.r,
          maxHeight: 56.r,
        ),
        contentPadding: REdgeInsets.all(16),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryFixed,
        focusedBorder: buildOutlinedBorder(context: context),
        enabledBorder: buildOutlinedBorder(context: context),
        focusedErrorBorder: buildOutlinedBorder(
            borderColor: AppColors.red.withValues(alpha: 0.5),
            context: context),
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
            AppIcons.gender,
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
      items: [
        DropdownMenuItem(
          value: controller.genderList[0],
          child: Row(
            children: [
              RPadding(
                padding: EdgeInsets.only(
                  right: startController.isArLanguage ? 0 : 8,
                  left: startController.isArLanguage ? 8 : 0,
                ),
                child: SvgPicture.asset(
                  AppIcons.maleGender,
                  width: 20.r,
                  height: 20.r,
                ),
              ),
              Text(controller.genderList[0]),
            ],
          ),
        ),
        DropdownMenuItem(
          value: controller.genderList[1],
          child: Row(
            children: [
              RPadding(
                padding: EdgeInsets.only(
                  right: startController.isArLanguage ? 0 : 8,
                  left: startController.isArLanguage ? 8 : 0,
                ),
                child: SvgPicture.asset(
                  AppIcons.femaleGender,
                  width: 20.r,
                  height: 20.r,
                ),
              ),
              Text(controller.genderList[1]),
            ],
          ),
        ),
      ],
      onChanged: (value) => controller.setGender(gender: value),
      buttonStyleData: ButtonStyleData(
        padding: REdgeInsets.only(
          right: startController.isArLanguage ? 0 : 8,
          left: startController.isArLanguage ? 8 : 0,
        ),
        overlayColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
        ),
        width: 0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: SvgPicture.asset(
          AppIcons.dropDown,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.white,
        ),
        maxHeight: 135.h,
      ),
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

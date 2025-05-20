import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  const CustomDropDownButtonFormField({
    super.key,
    required this.dropDownItemsList,
    this.contentPadding,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.prefixIcon,
    this.hintStyle,
    this.hintText,
  });
  final List<String> dropDownItemsList;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<StartCubit>(context);
    return DropdownButtonFormField2<String>(
      value: initialValue,
      isExpanded: true,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
          maxWidth: 56.r,
          maxHeight: 56.r,
        ),
        contentPadding: contentPadding ?? REdgeInsets.all(16),
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
        hintStyle: hintStyle ?? Theme.of(context).textTheme.labelSmall,
        hintText: hintText?.tr(),
        prefixIcon: prefixIcon,
        errorStyle: Theme.of(context).textTheme.titleSmall,
      ),
      items: dropDownItemsList
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
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
        color: borderColor ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

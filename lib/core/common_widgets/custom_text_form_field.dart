import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.maxLines,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.obscuringCharacter = "*",
    this.validator,
    this.textInputAction,
    this.hintStyle,
    this.contentPadding,
    this.style,
    this.prefixIcon,
    this.enabled = true,
    required this.labelText,
    this.labelStyle,
  });
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final Widget? prefixIcon;
  final bool enabled;
  final String? labelText;
  final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
          maxWidth: 56.r,
          maxHeight: 56.r,
        ),
        contentPadding: contentPadding ?? REdgeInsets.all(16),
        labelText: labelText?.tr(),
        labelStyle: labelStyle ?? Theme.of(context).textTheme.bodyLarge,
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryFixed,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.labelSmall,
        hintText: hintText?.tr(),
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
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorStyle: Theme.of(context).textTheme.titleSmall,
      ),
      enabled: enabled,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      validator: validator,
    );
  }

  OutlineInputBorder buildOutlinedBorder(
      {Color? borderColor, required BuildContext context}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: borderColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
    );
  }
}

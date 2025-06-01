import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionDialogButtons extends StatelessWidget {
  const OptionDialogButtons({
    super.key,
    required this.firstButtonTitle,
    this.firstButtonColor,
    this.firstButtonBorderColor,
    this.firstButtonTitleStyle,
    this.firstButtonAction,
    this.firstButtonHeight,
    required this.secondButtonTitle,
    this.secondButtonColor,
    this.secondButtonBorderColor,
    this.secondButtonTitleStyle,
    this.secondButtonAction,
    this.secondButtonHeight,
    this.dialogButton,
  });
  final String firstButtonTitle;
  final Color? firstButtonColor;
  final Color? firstButtonBorderColor;
  final TextStyle? firstButtonTitleStyle;
  final void Function()? firstButtonAction;
  final double? firstButtonHeight;
  final String secondButtonTitle;
  final Color? secondButtonColor;
  final Color? secondButtonBorderColor;
  final TextStyle? secondButtonTitleStyle;
  final void Function()? secondButtonAction;
  final double? secondButtonHeight;
  final Widget? dialogButton;
  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
      ),
      child: dialogButton ??
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: firstButtonAction,
                  buttonTitle: firstButtonTitle,
                  height: firstButtonHeight ?? 56.h,
                  borderColor: firstButtonBorderColor,
                  backgroundColor: firstButtonColor,
                  titleStyle: firstButtonTitleStyle,
                ),
              ),
              const RSizedBox(
                width: 16,
              ),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: secondButtonAction,
                  buttonTitle: secondButtonTitle,
                  height: secondButtonHeight ?? 56.h,
                  borderColor: secondButtonBorderColor,
                  backgroundColor: secondButtonColor,
                  titleStyle: secondButtonTitleStyle,
                ),
              ),
            ],
          ),
    );
  }
}

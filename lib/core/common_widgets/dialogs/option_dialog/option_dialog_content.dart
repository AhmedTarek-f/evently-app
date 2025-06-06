import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/dialogs/option_dialog/option_dialog_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionDialogContent extends StatelessWidget {
  const OptionDialogContent({
    super.key,
    required this.optionDialogContent,
    this.optionDialogStyle,
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
    this.contentHorizontalPadding,
    this.dialogHorizontalPadding,
    this.dialogContent,
    this.dialogButton,
  });
  final String optionDialogContent;
  final TextStyle? optionDialogStyle;
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
  final double? contentHorizontalPadding;
  final double? dialogHorizontalPadding;
  final Widget? dialogContent;
  final Widget? dialogButton;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      insetPadding:
          REdgeInsets.symmetric(horizontal: dialogHorizontalPadding ?? 12),
      child: Container(
        padding: REdgeInsets.only(
          top: 32.h,
          bottom: 16.h,
        ),
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryFixed,
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: contentHorizontalPadding ?? 0),
              child: dialogContent ??
                  Text(
                    optionDialogContent.tr(),
                    style: optionDialogStyle ??
                        Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
            ),
            const RSizedBox(
              height: 16,
            ),
            OptionDialogButtons(
              firstButtonTitle: firstButtonTitle.tr(),
              firstButtonAction: firstButtonAction,
              firstButtonBorderColor: firstButtonBorderColor,
              firstButtonColor: firstButtonColor,
              firstButtonHeight: firstButtonHeight,
              firstButtonTitleStyle: firstButtonTitleStyle,
              secondButtonTitle: secondButtonTitle.tr(),
              secondButtonAction: secondButtonAction,
              secondButtonBorderColor: secondButtonBorderColor,
              secondButtonColor: secondButtonColor,
              secondButtonHeight: secondButtonHeight,
              secondButtonTitleStyle: secondButtonTitleStyle,
              dialogButton: dialogButton,
            )
          ],
        ),
      ),
    );
  }
}

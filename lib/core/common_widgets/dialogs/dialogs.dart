import 'package:evently_app/core/common_widgets/dialogs/option_dialog/option_dialog_content.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  static Future<void> showOptionDialog({
    required BuildContext context,
    required String optionDialogContent,
    TextStyle? optionDialogStyle,
    required String firstButtonTitle,
    Color? firstButtonBorderColor,
    Color? firstButtonColor,
    TextStyle? firstButtonTitleStyle,
    void Function()? firstButtonAction,
    required String secondButtonTitle,
    double? firstButtonHeight,
    Color? secondButtonColor,
    Color? secondButtonBorderColor,
    TextStyle? secondButtonTitleStyle,
    void Function()? secondButtonAction,
    double? secondButtonHeight,
    String? dialogStartIcon,
    double? contentHorizontalPadding,
    double? dialogHorizontalPadding,
    final Widget? dialogContent,
    final Widget? dialogButton,
  }) async {
    return showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => OptionDialogContent(
        optionDialogContent: optionDialogContent,
        firstButtonTitle: firstButtonTitle,
        secondButtonTitle: secondButtonTitle,
        secondButtonTitleStyle: secondButtonTitleStyle,
        secondButtonHeight: secondButtonHeight,
        secondButtonColor: secondButtonColor,
        secondButtonBorderColor: secondButtonBorderColor,
        secondButtonAction: secondButtonAction,
        firstButtonTitleStyle: firstButtonTitleStyle,
        firstButtonHeight: firstButtonHeight,
        firstButtonColor: firstButtonColor,
        firstButtonBorderColor: firstButtonBorderColor,
        firstButtonAction: firstButtonAction,
        optionDialogStyle: optionDialogStyle,
        contentHorizontalPadding: contentHorizontalPadding,
        dialogHorizontalPadding: dialogHorizontalPadding,
        dialogContent: dialogContent,
        dialogButton: dialogButton,
      ),
    );
  }
}

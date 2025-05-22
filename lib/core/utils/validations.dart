import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';

abstract class Validations {
  static String? userNameValidation(String? firstName) {
    if (firstName?.trim() == "" ||
        (firstName?.isEmpty ?? true) ||
        firstName == null) {
      return AppText.userNameValidation.tr();
    }
    return null;
  }

  static String? emailValidation(String? email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email?.trim() == "" || (email?.isEmpty ?? true) || email == null) {
      return AppText.emailValidation1.tr();
    } else if (!emailRegex.hasMatch(email)) {
      return AppText.emailValidation2.tr();
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return AppText.passwordValidation1.tr();
    } else if (RegExp(r'\s').hasMatch(password)) {
      return AppText.passwordValidation2.tr();
    } else if (password.length < 8) {
      return AppText.passwordValidation3.tr();
    } else if (!RegExp(r'\d').hasMatch(password)) {
      return AppText.passwordValidation4.tr();
    } else if (password.length > 20) {
      return AppText.passwordValidation5.tr();
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return AppText.passwordConfirmationValidation1.tr();
    } else if (RegExp(r'\s').hasMatch(value)) {
      return AppText.passwordConfirmationValidation2.tr();
    } else if (value != password) {
      return AppText.passwordConfirmationValidation3.tr();
    }
    return null;
  }

  static String? eventTitleValidation(String? title) {
    if (title?.trim() == "" || (title?.isEmpty ?? true) || title == null) {
      return AppText.eventTitleValidation.tr();
    }
    return null;
  }

  static String? eventDescriptionValidation(String? description) {
    if (description?.trim() == "" ||
        (description?.isEmpty ?? true) ||
        description == null) {
      return AppText.eventDescriptionValidation.tr();
    }
    return null;
  }
}

import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial()) {
    onInit();
  }

  late final TextEditingController emailController;
  late final GlobalKey<FormState> forgetPasswordFormKey;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void onInit() {
    forgetPasswordFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void resetPassword() {
    if (forgetPasswordFormKey.currentState!.validate()) {
      emit(FormValidationSuccessState());
    } else {
      enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}

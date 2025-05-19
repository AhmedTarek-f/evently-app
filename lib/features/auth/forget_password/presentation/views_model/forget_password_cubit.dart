import 'package:evently_app/features/auth/forget_password/data/repositories/forget_password_repository.dart';
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
  bool isLoading = false;

  void onInit() {
    forgetPasswordFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  Future<void> resetPassword() async {
    if (forgetPasswordFormKey.currentState!.validate()) {
      isLoading = true;
      emit(SendResetPasswordLoadingState());
      var result = await ForgetPasswordRepository.sendPasswordResetEmail(
        email: emailController.text,
      );
      result.fold(
        (failure) {
          isLoading = false;
          emit(
            SendResetPasswordFailureState(
              errorMessage: failure.errorMessage,
            ),
          );
        },
        (sentReset) {
          isLoading = false;
          emit(SendResetPasswordSuccessState());
        },
      );
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

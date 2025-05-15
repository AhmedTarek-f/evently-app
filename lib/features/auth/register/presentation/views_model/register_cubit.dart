import 'package:evently_app/features/auth/register/presentation/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial()) {
    onInit();
  }

  late final GlobalKey<FormState> createAccountFormKey;
  late final TextEditingController userNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void onInit() {
    createAccountFormKey = GlobalKey<FormState>();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void togglePasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
    emit(ChangePasswordObscureState());
  }

  void toggleConfirmPasswordObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(ChangeConfirmPasswordObscureState());
  }

  void createAccount() {
    if (createAccountFormKey.currentState!.validate()) {
      emit(FormValidationSuccessState());
    } else {
      enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}

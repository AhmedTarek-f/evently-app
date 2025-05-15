import 'package:evently_app/features/auth/login/presentation/views_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    onInit();
  }

  late final GlobalKey<FormState> loginFormKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isObscure = true;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void toggleObscure() {
    isObscure = !isObscure;
    emit(ChangeObscureState());
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      emit(FormValidationSuccessState());
    } else {
      enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

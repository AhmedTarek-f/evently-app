import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/features/auth/login/data/repositories/login_repository.dart';
import 'package:evently_app/features/auth/login/presentation/views_model/login_state.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/auth/register/data/repositories/register_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      emit(LoginLoadingState());
      Either<Failure, UserCredential> result =
          await LoginRepository.loginWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      result.fold(
        (failure) => emit(
          LoginFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (loginSuccess) async {
          emit(LoginSuccessState());
        },
      );
    } else {
      enableAutoValidateMode();
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoadingState());
    Either<Failure, UserCredential> result =
        await LoginRepository.signInWithGoogle();
    result.fold(
      (failure) => emit(
        LoginFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (googleUserCredential) async {
        var currentUserResult = await RegisterRepository.addUser(
          userData: UserModel(
            id: googleUserCredential.user?.uid ?? "",
            userName: googleUserCredential.user?.displayName ?? "",
            email: googleUserCredential.user?.email ?? "",
            gender: "",
            photoUrl: googleUserCredential.user?.photoURL,
            favoriteEvents: [],
          ),
        );

        currentUserResult.fold(
          (failure) => LoginFailureState(
            errorMessage: failure.errorMessage,
          ),
          (userData) => emit(LoginSuccessState()),
        );
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

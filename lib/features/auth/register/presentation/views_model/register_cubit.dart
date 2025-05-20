import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/firestore_services/firestore_services.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/auth/register/data/repositories/register_repository.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial()) {
    onInit();
  }

  late final GlobalKey<FormState> createAccountFormKey;
  late final TextEditingController userNameController;
  late final TextEditingController emailController;
  String? selectedGender;
  final List<String> genderList = const [
    AppText.male,
    AppText.female,
  ];
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  void onInit() {
    createAccountFormKey = GlobalKey<FormState>();
    userNameController = TextEditingController();
    selectedGender = genderList[0];
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

  void setGender({required String? gender}) {
    selectedGender = gender;
  }

  Future<void> createAccount() async {
    if (createAccountFormKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      Either<Failure, UserCredential> result =
          await RegisterRepository.registerWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      result.fold(
        (failure) => emit(
          RegisterFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (registerSuccess) async {
          var result = await FireStoreServices.addUser(
            userData: UserModel(
              id: registerSuccess.user?.uid ?? "",
              userName: userNameController.text,
              email: emailController.text,
              gender: selectedGender!,
            ),
          );
          result.fold(
            (failure) => RegisterFailureState(
              errorMessage: failure.errorMessage,
            ),
            (success) => emit(RegisterSuccessState()),
          );
        },
      );
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

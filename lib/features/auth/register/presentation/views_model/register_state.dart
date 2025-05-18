sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class EnableAutoValidateModeState extends RegisterState {}

final class ChangePasswordObscureState extends RegisterState {}

final class ChangeConfirmPasswordObscureState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterFailureState extends RegisterState {
  RegisterFailureState({required this.errorMessage});
  final String errorMessage;
}

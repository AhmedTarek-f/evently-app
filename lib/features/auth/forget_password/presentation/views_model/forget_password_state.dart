sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class EnableAutoValidateModeState extends ForgetPasswordState {}

final class SendResetPasswordSuccessState extends ForgetPasswordState {}

final class SendResetPasswordLoadingState extends ForgetPasswordState {}

final class SendResetPasswordFailureState extends ForgetPasswordState {
  SendResetPasswordFailureState({required this.errorMessage});
  final String errorMessage;
}

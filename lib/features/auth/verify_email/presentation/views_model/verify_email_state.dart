sealed class VerifyEmailState {}

final class VerifyEmailInitial extends VerifyEmailState {}

final class SendEmailVerificationSuccessState extends VerifyEmailState {}

final class SendEmailVerificationLoadingState extends VerifyEmailState {}

final class SendEmailVerificationFailureState extends VerifyEmailState {
  SendEmailVerificationFailureState({required this.errorMessage});
  final String errorMessage;
}

final class LogoutSuccessState extends VerifyEmailState {}

final class EmailVerifiedState extends VerifyEmailState {}

final class LogoutFailureState extends VerifyEmailState {
  LogoutFailureState({required this.errorMessage});
  final String errorMessage;
}

final class FetchUserDataFailureState extends VerifyEmailState {
  FetchUserDataFailureState({required this.errorMessage});
  final String errorMessage;
}

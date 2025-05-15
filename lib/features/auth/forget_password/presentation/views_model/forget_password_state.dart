sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class EnableAutoValidateModeState extends ForgetPasswordState {}

final class FormValidationSuccessState extends ForgetPasswordState {}

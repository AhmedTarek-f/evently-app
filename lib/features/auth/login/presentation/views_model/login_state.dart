sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class EnableAutoValidateModeState extends LoginState {}

final class ChangeObscureState extends LoginState {}

final class FormValidationSuccessState extends LoginState {}

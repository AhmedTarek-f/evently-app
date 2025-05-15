sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class EnableAutoValidateModeState extends RegisterState {}

final class FormValidationSuccessState extends RegisterState {}

final class ChangePasswordObscureState extends RegisterState {}

final class ChangeConfirmPasswordObscureState extends RegisterState {}

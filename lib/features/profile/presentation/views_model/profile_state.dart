sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class LogoutSuccessState extends ProfileState {}

final class LogoutLoadingState extends ProfileState {}

final class LogoutFailureState extends ProfileState {
  LogoutFailureState({required this.errorMessage});
  final String errorMessage;
}

final class DeleteAccountSuccessState extends ProfileState {}

final class DeleteAccountLoadingState extends ProfileState {}

final class DeleteAccountFailureState extends ProfileState {
  DeleteAccountFailureState({required this.errorMessage});
  final String errorMessage;
}

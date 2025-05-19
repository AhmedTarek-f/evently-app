sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class LogoutSuccessState extends ProfileState {}

final class LogoutLoadingState extends ProfileState {}

final class LogoutFailureState extends ProfileState {
  LogoutFailureState({required this.errorMessage});
  final String errorMessage;
}

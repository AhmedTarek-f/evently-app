sealed class EventlyBottomNavigationState {}

final class EventlyBottomNavigationInitial
    extends EventlyBottomNavigationState {}

final class ChangeTapState extends EventlyBottomNavigationState {}

final class FetchUserDataSuccessState extends EventlyBottomNavigationState {}

final class FetchUserDataLoadingState extends EventlyBottomNavigationState {}

final class FetchUserDataFailureState extends EventlyBottomNavigationState {
  FetchUserDataFailureState({required this.errorMessage});
  final String errorMessage;
}

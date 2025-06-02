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

final class FetchUserLocationSuccessState
    extends EventlyBottomNavigationState {}

final class FetchUserLocationLoadingState
    extends EventlyBottomNavigationState {}

final class FetchUserLocationFailureState extends EventlyBottomNavigationState {
  FetchUserLocationFailureState({required this.errorMessage});
  final String errorMessage;
}

final class GetLocationDataFailureState extends EventlyBottomNavigationInitial {
  GetLocationDataFailureState({required this.errorMessage});
  final String errorMessage;
}

final class DeleteEventState extends EventlyBottomNavigationState {}

final class ChangeParticipationState extends EventlyBottomNavigationState {}

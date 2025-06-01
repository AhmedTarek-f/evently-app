sealed class EventDetailsState {}

final class EventDetailsInitial extends EventDetailsState {}

final class CustomIconLoadState extends EventDetailsState {}

final class MapStyleLoadState extends EventDetailsState {}

final class FetchEventCreatorSuccessState extends EventDetailsState {}

final class FetchEventCreatorLoadingState extends EventDetailsState {}

final class FetchEventCreatorFailureState extends EventDetailsState {
  FetchEventCreatorFailureState({required this.errorMessage});
  final String errorMessage;
}

final class FetchParticipateUsersSuccessState extends EventDetailsState {}

final class FetchParticipateUsersLoadingState extends EventDetailsState {}

final class FetchParticipateUsersFailureState extends EventDetailsState {
  FetchParticipateUsersFailureState({required this.errorMessage});
  final String errorMessage;
}

final class ChangeParticipateUsersState extends EventDetailsState {}

final class GetUserJoiningState extends EventDetailsState {}

final class ToggleParticipateInOutEventSuccessState extends EventDetailsState {}

final class ToggleParticipateInOutEventLoadingState extends EventDetailsState {}

final class ToggleParticipateInOutEventFailureState extends EventDetailsState {
  ToggleParticipateInOutEventFailureState({required this.errorMessage});
  final String errorMessage;
}

final class EventDetailsEditedState extends EventDetailsState {}

final class DeleteEventSuccessState extends EventDetailsState {}

final class DeleteEventLoadingState extends EventDetailsState {}

final class DeleteEventFailureState extends EventDetailsState {
  DeleteEventFailureState({required this.errorMessage});
  final String errorMessage;
}

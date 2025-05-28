sealed class CreateEventState {}

final class CreateEventInitial extends CreateEventState {}

final class ChangeSelectedCategoryState extends CreateEventState {}

final class EnableAutoValidateModeState extends CreateEventState {}

final class PickingDateState extends CreateEventState {}

final class PickingDateValidationState extends CreateEventState {}

final class PickingTimeState extends CreateEventState {}

final class PickingTimeValidationState extends CreateEventState {}

final class CreateEventSuccessState extends CreateEventState {}

final class CreateEventLoadingState extends CreateEventState {}

final class CreateEventFailureState extends CreateEventState {
  CreateEventFailureState({required this.errorMessage});
  final String errorMessage;
}

final class SelectEventLocationSuccessState extends CreateEventState {}

final class SelectEventLocationLoadingState extends CreateEventState {}

final class SelectEventLocationFailureState extends CreateEventState {
  SelectEventLocationFailureState({required this.errorMessage});
  final String errorMessage;
}

final class EventLocationValidationState extends CreateEventState {}

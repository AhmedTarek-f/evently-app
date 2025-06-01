sealed class EditEventState {}

final class EditEventInitial extends EditEventState {}

final class ChangeSelectedCategoryState extends EditEventState {}

final class EnableAutoValidateModeState extends EditEventState {}

final class PickingDateState extends EditEventState {}

final class PickingDateValidationState extends EditEventState {}

final class PickingTimeState extends EditEventState {}

final class PickingTimeValidationState extends EditEventState {}

final class EditEventSuccessState extends EditEventState {}

final class EditEventLoadingState extends EditEventState {}

final class EditEventFailureState extends EditEventState {
  EditEventFailureState({required this.errorMessage});
  final String errorMessage;
}

final class SelectEventLocationSuccessState extends EditEventState {}

final class SelectEventLocationLoadingState extends EditEventState {}

final class SelectEventLocationFailureState extends EditEventState {
  SelectEventLocationFailureState({required this.errorMessage});
  final String errorMessage;
}

final class EventLocationValidationState extends EditEventState {}

final class NoChangeState extends EditEventState {}

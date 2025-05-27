sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangeSelectedCategoryState extends HomeState {}

final class FetchEventsLoadingState extends HomeState {}

final class FetchEventsSuccessState extends HomeState {}

final class FetchEventsFailureState extends HomeState {
  FetchEventsFailureState({required this.errorMessage});
  final String errorMessage;
}

final class FetchCachedEventsState extends HomeState {}

final class ToggleFavoriteLoadingState extends HomeState {
  ToggleFavoriteLoadingState({required this.eventId});
  final String eventId;
}

final class ToggleFavoriteSuccessState extends HomeState {}

final class ToggleFavoriteFailureState extends HomeState {
  ToggleFavoriteFailureState({required this.errorMessage});
  final String errorMessage;
}

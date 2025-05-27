sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class DeleteFavoriteEventLoadingState extends FavoriteState {
  DeleteFavoriteEventLoadingState({required this.eventId});
  final String eventId;
}

final class DeleteFavoriteEventSuccessState extends FavoriteState {}

final class DeleteFavoriteEventFailureState extends FavoriteState {
  DeleteFavoriteEventFailureState({required this.errorMessage});
  final String errorMessage;
}

final class ChangeSearchFieldValueState extends FavoriteState {}

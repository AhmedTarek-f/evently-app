sealed class MapState {}

final class MapInitial extends MapState {}

final class CustomIconLoadState extends MapState {}

final class MapStyleLoadState extends MapState {}

final class AddingMarkerState extends MapState {}

final class GetLocationDataFailureState extends MapState {
  GetLocationDataFailureState({required this.errorMessage});
  final String errorMessage;
}

final class MyLocationMarkerChangeState extends MapState {}

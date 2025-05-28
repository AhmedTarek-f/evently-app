sealed class ChooseEventLocationState {}

final class ChooseEventLocationInitial extends ChooseEventLocationState {}

final class CustomIconLoadState extends ChooseEventLocationState {}

final class MapStyleLoadState extends ChooseEventLocationState {}

final class AddingMarkerState extends ChooseEventLocationState {}

final class GetLocationDataFailureState extends ChooseEventLocationState {
  GetLocationDataFailureState({required this.errorMessage});
  final String errorMessage;
}

final class MyLocationMarkerChangeState extends ChooseEventLocationState {}

final class SelectEventLocationState extends ChooseEventLocationState {}

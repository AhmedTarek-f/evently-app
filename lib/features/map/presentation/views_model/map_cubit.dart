import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/features/map/data/repositories/map_repository.dart';
import 'package:evently_app/features/map/presentation/views_model/map_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(BuildContext context)
      : _context = context,
        super(MapInitial()) {
    onInit();
  }
  final BuildContext _context;
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late BitmapDescriptor customIcon;
  LocationData? myLocation;
  String? nightMapStyle;
  bool isFirstCall = true;
  Set<Marker> markers = {};

  void onInit() async {
    initialCameraPosition = const CameraPosition(
      target: LatLng(29.973807, 31.275680),
      zoom: 11,
    );
    if (BlocProvider.of<StartCubit>(_context).isDarkMode) await initMapStyle();
    await loadCustomIcon();
    // setInitMarkers();
  }

  Future<void> loadCustomIcon() async {
    customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      AppImages.mapMarker,
      width: 34.r,
      height: 34.r,
    );
    emit(CustomIconLoadState());
  }

  Future<void> initMapStyle() async {
    nightMapStyle =
        await rootBundle.loadString("assets/map_styles/night_map_style.json");
    emit(MapStyleLoadState());
  }

  void addMarker({required LatLng position}) {
    markers.add(Marker(
      markerId: const MarkerId("event_marker"),
      position: position,
      icon: customIcon,
    ));
    emit(AddingMarkerState());
  }

  Future<void> updateMyCamera() async {
    var result = await MapRepository.getLocation();
    result.fold(
      (failure) => emit(
        GetLocationDataFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (locationData) => myLocation = locationData,
    );
    final LatLng newPosition = LatLng(
      myLocation?.latitude! ?? 0,
      myLocation?.longitude! ?? 0,
    );
    CameraPosition cameraPosition =
        CameraPosition(target: newPosition, zoom: 17);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markers.add(
      Marker(
        markerId: const MarkerId("event_marker"),
        icon: customIcon,
        position: newPosition,
      ),
    );
    emit(MyLocationMarkerChangeState());
  }

  Future<void> animateCameraToMyLocation() async {
    if (myLocation == null) {
      var result = await MapRepository.getLocation();
      result.fold(
        (failure) => emit(
          GetLocationDataFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (locationData) => myLocation = locationData,
      );
    }
    final LatLng newPosition = LatLng(
      myLocation?.latitude! ?? 0,
      myLocation?.longitude! ?? 0,
    );
    CameraPosition cameraPosition =
        CameraPosition(target: newPosition, zoom: 17);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markers.add(
      Marker(
        markerId: const MarkerId("event_marker"),
        icon: customIcon,
        position: newPosition,
      ),
    );
    emit(MyLocationMarkerChangeState());
  }

  @override
  Future<void> close() {
    googleMapController?.dispose();
    return super.close();
  }
}

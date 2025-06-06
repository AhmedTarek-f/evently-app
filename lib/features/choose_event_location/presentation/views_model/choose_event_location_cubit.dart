import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/choose_event_location/data/repositories/choose_event_location_repository.dart';
import 'package:evently_app/features/choose_event_location/presentation/views_model/choose_event_location_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ChooseEventLocationCubit extends Cubit<ChooseEventLocationState> {
  ChooseEventLocationCubit(BuildContext context,
      [bool? isFromEdit, LatLng? eventLocation])
      : _context = context,
        isEditEvent = isFromEdit,
        selectedLocation = eventLocation,
        super(ChooseEventLocationInitial()) {
    onInit();
  }
  final BuildContext _context;
  final bool? isEditEvent;
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late BitmapDescriptor customIcon;
  LocationData? myLocation;
  String? nightMapStyle;
  Set<Marker> markers = {};
  LatLng? selectedLocation;

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

  void changeSelectedLocation({required LatLng eventLocation}) {
    selectedLocation = eventLocation;
    markers.add(
      Marker(
        markerId: const MarkerId("event_marker"),
        position: eventLocation,
        icon: customIcon,
        infoWindow: InfoWindow(
          title: AppText.eventLocation.tr(),
        ),
      ),
    );
    emit(AddingMarkerState());
  }

  void selectEventLocation() {
    emit(SelectEventLocationState());
  }

  void selectEventLocationEdit() {
    emit(SelectEventLocationEditState());
  }

  void animateCameraToEventLocation() {
    CameraPosition cameraPosition =
        CameraPosition(target: selectedLocation!, zoom: 17);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markers.add(
      Marker(
        markerId: const MarkerId("event_marker"),
        icon: customIcon,
        position: selectedLocation!,
      ),
    );
    emit(MyLocationMarkerChangeState());
  }

  Future<void> animateCameraToMyLocation() async {
    var result = await ChooseEventLocationRepository.getLocation();
    result.fold(
      (failure) => emit(
        GetLocationDataFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (locationData) => myLocation = locationData,
    );
    if (myLocation != null) {
      final LatLng newPosition = LatLng(
        myLocation!.latitude!,
        myLocation!.longitude!,
      );
      selectedLocation = newPosition;
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
  }

  @override
  Future<void> close() {
    googleMapController?.dispose();
    return super.close();
  }
}

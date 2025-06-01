import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
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
  Set<Marker> markers = {};

  void onInit() async {
    initialCameraPosition = const CameraPosition(
      target: LatLng(29.973807, 31.275680),
      zoom: 11,
    );
    myLocation =
        BlocProvider.of<EventlyBottomNavigationCubit>(_context).userLocation;
    if (BlocProvider.of<StartCubit>(_context).isDarkMode) await initMapStyle();
    await loadCustomIcon();
    addingEventsMarkers();
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

  Future<void> animateCameraToEventLocation({
    required EventModel eventData,
  }) async {
    final LatLng newPosition = LatLng(
      double.parse(eventData.eventLocationLat ?? "0"),
      double.parse(eventData.eventLocationLong ?? "0"),
    );
    CameraPosition cameraPosition =
        CameraPosition(target: newPosition, zoom: 17);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markers.add(
      Marker(
        markerId: MarkerId("event_marker${eventData.eventId}"),
        icon: customIcon,
        position: newPosition,
        infoWindow: InfoWindow(title: eventData.eventTitle),
      ),
    );
  }

  void addingEventsMarkers() {
    EventlyMethodsHelper.allEvents
        .map(
          (event) => markers.add(
            Marker(
              markerId: MarkerId("event_marker${event.eventId}"),
              icon: customIcon,
              position: LatLng(
                double.parse(
                  event.eventLocationLat ?? "0",
                ),
                double.parse(
                  event.eventLocationLong ?? "0",
                ),
              ),
              infoWindow: InfoWindow(title: event.eventTitle),
            ),
          ),
        )
        .toList();
  }

  Future<void> animateCameraToMyLocation() async {
    if (myLocation == null) {
      final eventlyController =
          BlocProvider.of<EventlyBottomNavigationCubit>(_context);
      await eventlyController.getUserLocation();
      myLocation = eventlyController.userLocation;
    }
    if (myLocation != null) {
      final LatLng newPosition = LatLng(
        myLocation!.latitude!,
        myLocation!.longitude!,
      );
      CameraPosition cameraPosition =
          CameraPosition(target: newPosition, zoom: 17);
      googleMapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      markers.add(
        Marker(
          markerId: const MarkerId("my_location"),
          icon: customIcon,
          position: newPosition,
          infoWindow: const InfoWindow(title: "My Location"),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    googleMapController?.dispose();
    return super.close();
  }
}

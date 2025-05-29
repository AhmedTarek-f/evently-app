import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/location_service/location_service.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/evently_bottom_navigation/data/data_sources/remote_data/evently_bottom_navigation_remote_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract class EventlyBottomNavRepository {
  static Future<Either<Failure, UserModel>> getUserData() async {
    return await EventlyBottomNavigationRemoteData.getUser(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "");
  }

  static Future<Either<Failure, LocationData>> getLocation() async {
    return await LocationService.getLocation();
  }

  static Future<Either<Failure, List<Placemark>>> fetchUserLocationName(
      {required LatLng eventLocation}) async {
    return await EventlyBottomNavigationRemoteData.fetchUserLocationName(
      eventLocation: eventLocation,
    );
  }
}

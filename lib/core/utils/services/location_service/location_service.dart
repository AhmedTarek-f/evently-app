import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/location_errors.dart';
import 'package:evently_app/core/utils/errors/location_exceptions.dart';
import 'package:location/location.dart';

abstract class LocationService {
  static final Location _location = Location();

  static Future<Either<Failure, void>> _checkAndRequestLocationService() async {
    bool isServiceEnabled = await _location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await _location.requestService();
      if (!isServiceEnabled) {
        return left(
          LocationErrors.getExceptionMessage(
            error: LocationServiceUnEnabledException(),
          ),
        );
      }
    }
    return right(null);
  }

  static Future<Either<Failure, void>>
      _checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return left(
        LocationErrors.getExceptionMessage(
          error: LocationPermissionDeniedForeverException(),
        ),
      );
    } else if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return left(
          LocationErrors.getExceptionMessage(
            error: LocationPermissionNotGrantedException(),
          ),
        );
      }
    }
    return right(null);
  }

  static Future<Either<Failure, LocationData>> getLocation() async {
    try {
      await _checkAndRequestLocationService();
      await _checkAndRequestLocationPermission();
      final location = await _location.getLocation();
      return right(location);
    } catch (error) {
      return left(LocationErrors.getExceptionMessage(error: error));
    }
  }
}

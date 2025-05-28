import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/location_service/location_service.dart';
import 'package:location/location.dart';

abstract class MapRepository {
  static Future<Either<Failure, LocationData>> getLocation() async {
    return await LocationService.getLocation();
  }
}

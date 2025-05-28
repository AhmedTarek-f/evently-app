import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/features/create_event/data/data_sources/remote_data_sources/create_event_remote_data.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CreateEventRepository {
  static Future<Either<Failure, void>> createEvent({
    required EventModel eventData,
  }) async {
    return await CreateEventRemoteData.createEvent(
      eventData: eventData,
    );
  }

  static Future<Either<Failure, List<Placemark>>> getEventLocationName(
      {required LatLng eventLocation}) async {
    return await CreateEventRemoteData.getEventLocationName(
      eventLocation: eventLocation,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CreateEventRemoteData {
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<EventModel> _getEventsCollection() {
    return _db.collection("Events").withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromFireStore(snapshot),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<Either<Failure, void>> createEvent({
    required EventModel eventData,
  }) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      await _getEventsCollection().doc(eventData.eventId).set(eventData);
      return right(null);
    } catch (error) {
      if (error is FirebaseException) {
        return left(FirebaseErrors.firebaseExceptions(error));
      }
      return left(
        FirebaseErrors(
          errorMessage: "${AppText.unknownErrorMessage} ${error.toString()}",
        ),
      );
    }
  }

  static Future<Either<Failure, List<Placemark>>> getEventLocationName(
      {required LatLng eventLocation}) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        eventLocation.latitude,
        eventLocation.longitude,
      );
      return right(placeMarks);
    } catch (error) {
      if (error is PlatformException) {
        return left(
          FirebaseErrors(
            errorMessage: AppText.networkRequestFailed.tr(),
          ),
        );
      }
      return left(
        FirebaseErrors(
          errorMessage: "${AppText.unknownErrorMessage} ${error.toString()}",
        ),
      );
    }
  }
}

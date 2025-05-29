import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class EventlyBottomNavigationRemoteData {
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<UserModel> _getUserCollection() {
    return _db.collection("User").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<Either<Failure, UserModel>> getUser({
    required String userId,
  }) async {
    try {
      final snapshot = await _getUserCollection().doc(userId).get();
      final UserModel userData = snapshot.data() ?? UserModel.empty();
      return right(userData);
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

  static Future<Either<Failure, List<Placemark>>> fetchUserLocationName(
      {required LatLng eventLocation}) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        eventLocation.latitude,
        eventLocation.longitude,
      );
      return right(placeMarks);
    } catch (error) {
      return left(
        FirebaseErrors(
          errorMessage: "${AppText.unknownErrorMessage} ${error.toString()}",
        ),
      );
    }
  }
}

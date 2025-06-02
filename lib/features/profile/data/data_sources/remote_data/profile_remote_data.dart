import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/core/utils/services/auth_services/additional_auth_services/additional_auth_services.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRemoteData {
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<EventModel> _getEventsCollection() {
    return _db.collection("Events").withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromFireStore(snapshot),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<Either<Failure, void>> logout() async {
    return await AdditionalAuthServices.logout();
  }

  static Future<Either<Failure, void>> deleteUserAccount(
      {required String userId}) async {
    return await AdditionalAuthServices.deleteUserAccount(userId: userId);
  }

  static Future<Either<Failure, void>> deleteUserRelatedEvents({
    required String userId,
  }) async {
    try {
      final List<EventModel> userEventsCreatedList =
          EventlyMethodsHelper.allEvents
              .where(
                (event) => event.eventCreatorId == userId,
              )
              .toList();
      final List<EventModel> userParticipatedInEventsList =
          EventlyMethodsHelper.allEvents
              .where(
                (event) => event.participateUsers?.contains(userId) ?? false,
              )
              .toList();
      for (EventModel event in userEventsCreatedList) {
        await _getEventsCollection().doc(event.eventId).delete();
      }
      for (EventModel event in userParticipatedInEventsList) {
        event.participateUsers?.removeWhere((id) => id == userId);
        await _getEventsCollection().doc(event.eventId).update(
          {
            "ParticipateUsers": event.participateUsers ?? [],
          },
        );
      }
      return right(null);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(FirebaseErrors.firebaseAuth(e));
      } else if (e is FirebaseException) {
        return left(FirebaseErrors.firebaseExceptions(e));
      }
      return left(
        FirebaseErrors(
          errorMessage: "${AppText.unknownErrorMessage} ${e.toString()}",
        ),
      );
    }
  }
}

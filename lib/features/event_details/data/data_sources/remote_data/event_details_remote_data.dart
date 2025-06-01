import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class EventDetailsRemoteData {
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<UserModel> _getUserCollection() {
    return _db.collection("User").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static CollectionReference<EventModel> _getEventsCollection() {
    return _db.collection("Events").withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromFireStore(snapshot),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<Either<Failure, UserModel>> fetchEventCreator({
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

  static Future<Either<Failure, List<UserModel>>> fetchParticipateUsers({
    required List<String> participateUserIds,
  }) async {
    try {
      if (participateUserIds.isNotEmpty) {
        final snapshot = await _getUserCollection()
            .where("Id", whereIn: participateUserIds)
            .get();

        final List<UserModel> participateUserList =
            snapshot.docs.map((user) => user.data()).toList();
        return right(participateUserList);
      }
      return right([]);
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

  static Future<Either<Failure, void>> participateInEvent({
    required String eventId,
    required List<String> participateUserIds,
  }) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      await _getEventsCollection().doc(eventId).update({
        "ParticipateUsers": participateUserIds,
      });
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
}

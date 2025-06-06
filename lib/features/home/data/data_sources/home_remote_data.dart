import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class HomeRemoteData {
  static final _db = FirebaseFirestore.instance;
  static CollectionReference<EventModel> _getEventsCollection() {
    return _db.collection("Events").withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromFireStore(snapshot),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static CollectionReference<UserModel> _getUserCollection() {
    return _db.collection("User").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Stream<Either<Failure, List<EventModel>>> fetchAllEvents() async* {
    try {
      yield* _getEventsCollection()
          .where(
            "EventDate",
            isGreaterThanOrEqualTo: Timestamp.now(),
          )
          .orderBy("EventDate")
          .snapshots()
          .map(
            (snapshot) => right<Failure, List<EventModel>>(
              snapshot.docs.map((e) => e.data()).toList(),
            ),
          );
    } catch (error) {
      if (error is FirebaseException) {
        yield* Stream.value(
          left(
            FirebaseErrors.firebaseExceptions(
              error,
            ),
          ),
        );
      }
      yield* Stream.value(
        left(
          FirebaseErrors(
            errorMessage: "${AppText.unknownErrorMessage} ${error.toString()}",
          ),
        ),
      );
    }
  }

  static Future<Either<Failure, void>> updateFavoriteEvents({
    required String userId,
    required List<String> favoriteEventsList,
  }) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return left(const FirebaseErrors(
        errorMessage: AppText.networkRequestFailed,
      ));
    }
    try {
      await _getUserCollection().doc(userId).update(
        {
          "FavoriteEvents": favoriteEventsList,
        },
      );
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

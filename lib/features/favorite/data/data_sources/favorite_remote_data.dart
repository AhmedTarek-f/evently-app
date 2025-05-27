import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';

abstract class FavoriteRemoteData {
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<UserModel> _getUserCollection() {
    return _db.collection("User").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<Either<Failure, void>> updateFavoriteEvents({
    required String userId,
    required List<String> favoriteEventsList,
  }) async {
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

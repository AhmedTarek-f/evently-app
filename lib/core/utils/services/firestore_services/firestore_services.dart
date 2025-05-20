import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';

abstract class FireStoreServices {
  static late UserModel? currentUserData;
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<UserModel> getUserCollection() {
    return _db.collection("User").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<Either<Failure, UserModel>> addUser({
    required UserModel userData,
  }) async {
    try {
      await getUserCollection().doc(userData.id).set(userData);
      return right(userData);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirebaseErrors.firebaseExceptions(e));
      }
      return left(
        FirebaseErrors(
          errorMessage: "${AppText.unknownErrorMessage} ${e.toString()}",
        ),
      );
    }
  }

  static Future<Either<Failure, UserModel>> getUser({
    required String userId,
  }) async {
    try {
      final snapshot = await getUserCollection().doc(userId).get();
      final UserModel userData = snapshot.data() ?? UserModel.empty();
      return right(userData);
    } catch (e) {
      if (e is FirebaseException) {
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

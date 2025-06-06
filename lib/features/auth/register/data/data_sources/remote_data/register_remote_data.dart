import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';

abstract class RegisterRemoteData {
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<UserModel> _getUserCollection() {
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
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      await _getUserCollection().doc(userData.id).set(userData);
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
}

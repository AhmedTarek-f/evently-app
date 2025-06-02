import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AdditionalAuthServices {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static CollectionReference<UserModel> _getUserCollection() {
    return _db.collection("User").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  // Forget Password
  static Future<Either<Failure, void>> sendPasswordResetEmail(
      {required String email}) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      await _auth.sendPasswordResetEmail(email: email);
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

  static Future<Either<Failure, UserCredential>>
      reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      UserCredential userCredential =
          await _auth.currentUser!.reauthenticateWithCredential(credential);
      return right(userCredential);
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

  // Mail Verification
  static Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      await _auth.currentUser?.sendEmailVerification();
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

  static Future<Either<Failure, void>> logout() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      await GoogleSignIn().signOut();
      await _auth.signOut();
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

  static Future<Either<Failure, void>> deleteUserAccount(
      {required String userId}) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      final String provider =
          _auth.currentUser?.providerData.map((e) => e.providerId).first ?? "";
      if (provider.isNotEmpty) {
        if (provider == "google.com") {
          await _getUserCollection().doc(userId).delete();
          await _auth.currentUser?.delete();
          await GoogleSignIn().disconnect();
        } else if (provider == "password") {
          await _getUserCollection().doc(userId).delete();
          await _auth.currentUser?.delete();
        }
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

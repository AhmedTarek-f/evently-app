import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AdditionalAuthServices {
  static final _auth = FirebaseAuth.instance;

  // Forget Password
  static Future<Either<Failure, void>> sendPasswordResetEmail(
      {required String email}) async {
    try {
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
}

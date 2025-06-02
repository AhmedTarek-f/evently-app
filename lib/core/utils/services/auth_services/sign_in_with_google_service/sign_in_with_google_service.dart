import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignInWithGoogleService {
  static final _auth = FirebaseAuth.instance;
  static Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return left(const FirebaseErrors(
          errorMessage: AppText.networkRequestFailed,
        ));
      }
      late final OAuthCredential credential;
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      try {
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
      } catch (e) {
        throw "Login with google has been canceled";
      }
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return right(userCredential);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(FirebaseErrors.firebaseAuth(e));
      } else if (e is FirebaseException) {
        return left(FirebaseErrors.firebaseExceptions(e));
      } else if (e == "Login with google has been canceled") {
        return left(
          const FirebaseErrors(
            errorMessage: AppText.googleLoginCanceled,
          ),
        );
      }
      return left(
        FirebaseErrors(
          errorMessage: "${AppText.unknownErrorMessage} ${e.toString()}",
        ),
      );
    }
  }
}

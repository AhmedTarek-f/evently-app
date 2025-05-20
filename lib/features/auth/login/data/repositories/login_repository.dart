import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/auth_services/sign_in_with_email_and_password_service/sign_in_with_email_and_password_service.dart';
import 'package:evently_app/core/utils/services/auth_services/sign_in_with_google_service/sign_in_with_google_service.dart';
import 'package:evently_app/core/utils/services/firestore_services/firestore_services.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  static Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await SignInWithEmailAndPasswordService.loginWithEmailAndPassword(
      email,
      password,
    );
  }

  static Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    return await SignInWithGoogleService.signInWithGoogle();
  }

  static Future<Either<Failure, UserModel>> getUserData() async {
    return await FireStoreServices.getUser(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "");
  }
}

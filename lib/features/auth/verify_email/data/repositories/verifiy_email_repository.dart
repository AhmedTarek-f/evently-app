import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/auth_services/additional_auth_services/additional_auth_services.dart';
import 'package:evently_app/core/utils/services/firestore_services/firestore_services.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class VerifyEmailRepository {
  static Future<Either<Failure, void>> sendEmailVerification() async {
    return await AdditionalAuthServices.sendEmailVerification();
  }

  static Future<Either<Failure, void>> logout() async {
    return await AdditionalAuthServices.logout();
  }

  static Future<Either<Failure, UserModel>> getUserData() async {
    return await FireStoreServices.getUser(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "");
  }
}

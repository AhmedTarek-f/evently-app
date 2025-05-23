import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/auth_services/register_with_email_and_password_service/register_with_email_and_password_service.dart';
import 'package:evently_app/features/auth/register/data/data_sources/remote_data/register_remote_data.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterRepository {
  static Future<Either<Failure, UserCredential>> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await RegisterWithEmailAndPasswordService
        .registerWithEmailAndPassword(
      email,
      password,
    );
  }

  static Future<Either<Failure, UserModel>> addUser({
    required UserModel userData,
  }) async {
    return await RegisterRemoteData.addUser(userData: userData);
  }
}

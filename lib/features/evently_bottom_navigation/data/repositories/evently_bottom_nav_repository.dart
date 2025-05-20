import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/firestore_services/firestore_services.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class EventlyBottomNavRepository {
  static Future<Either<Failure, UserModel>> getUserData() async {
    return await FireStoreServices.getUser(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "");
  }
}

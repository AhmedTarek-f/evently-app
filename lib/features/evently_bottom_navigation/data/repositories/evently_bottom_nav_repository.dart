import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/evently_bottom_navigation/data/data_sources/remote_data/evently_bottom_navigation_remote_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class EventlyBottomNavRepository {
  static Future<Either<Failure, UserModel>> getUserData() async {
    return await EventlyBottomNavigationRemoteData.getUser(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "");
  }
}

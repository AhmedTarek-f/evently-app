import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/features/profile/data/data_sources/remote_data/profile_remote_data.dart';

abstract class ProfileRepository {
  static Future<Either<Failure, void>> logout() async {
    return await ProfileRemoteData.logout();
  }

  static Future<Either<Failure, void>> deleteUserAccount({
    required String userId,
  }) async {
    return await ProfileRemoteData.deleteUserAccount(userId: userId);
  }

  static Future<Either<Failure, void>> deleteUserRelatedEvents({
    required String userId,
  }) async {
    return await ProfileRemoteData.deleteUserRelatedEvents(
      userId: userId,
    );
  }
}

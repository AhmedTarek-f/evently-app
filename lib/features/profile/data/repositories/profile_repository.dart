import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/auth_services/additional_auth_services/additional_auth_services.dart';

abstract class ProfileRepository {
  static Future<Either<Failure, void>> logout() async {
    return await AdditionalAuthServices.logout();
  }
}

import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/services/auth_services/additional_auth_services/additional_auth_services.dart';

abstract class ForgetPasswordRepository {
  static Future<Either<Failure, void>> sendPasswordResetEmail(
      {required String email}) async {
    return await AdditionalAuthServices.sendPasswordResetEmail(
      email: email,
    );
  }
}

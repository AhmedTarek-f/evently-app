import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/errors/location_exceptions.dart';
import 'package:flutter/services.dart';

class LocationErrors extends Failure {
  const LocationErrors({required super.errorMessage});
  factory LocationErrors.getExceptionMessage({required Object error}) {
    switch (error) {
      case LocationServiceUnEnabledException():
        return LocationErrors(errorMessage: AppText.locationException1.tr());
      case LocationPermissionDeniedForeverException():
        return LocationErrors(errorMessage: AppText.locationException2.tr());
      case LocationPermissionNotGrantedException():
        return LocationErrors(errorMessage: AppText.locationException3.tr());
      case PlatformException():
        return const LocationErrors(errorMessage: AppText.locationException5);
      default:
        return LocationErrors(errorMessage: AppText.locationException4.tr());
    }
  }
}

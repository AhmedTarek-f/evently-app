abstract class LocationServiceException implements Exception {}

class LocationServiceUnEnabledException extends LocationServiceException {}

class LocationPermissionDeniedForeverException
    extends LocationServiceException {}

class LocationPermissionNotGrantedException extends LocationServiceException {}

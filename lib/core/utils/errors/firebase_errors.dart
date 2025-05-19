import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrors extends Failure {
  const FirebaseErrors({required super.errorMessage});

  factory FirebaseErrors.firebaseAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return FirebaseErrors(errorMessage: AppText.emailAlreadyInUse.tr());
      case 'invalid-email':
        return FirebaseErrors(errorMessage: AppText.invalidEmail.tr());
      case 'network-request-failed':
        return FirebaseErrors(errorMessage: AppText.networkRequestFailed.tr());
      case 'weak-password':
        return FirebaseErrors(errorMessage: AppText.weakPassword.tr());
      case 'user-disabled':
        return FirebaseErrors(errorMessage: AppText.userDisabled.tr());
      case 'user-not-found':
        return FirebaseErrors(errorMessage: AppText.userNotFound.tr());
      case 'invalid-verification-code':
        return FirebaseErrors(
            errorMessage: AppText.invalidVerificationCode.tr());
      case 'invalid-verification-id':
        return FirebaseErrors(errorMessage: AppText.invalidVerificationId.tr());
      case 'quota-exceeded':
        return FirebaseErrors(errorMessage: AppText.quotaExceeded.tr());
      case 'email-already-exists':
        return FirebaseErrors(errorMessage: AppText.emailAlreadyExists.tr());
      case 'provider-already-linked':
        return FirebaseErrors(errorMessage: AppText.providerAlreadyLinked.tr());
      case 'requires-recent-login':
        return FirebaseErrors(errorMessage: AppText.requiresRecentLogin.tr());
      case 'credential-already-in-use':
        return FirebaseErrors(
            errorMessage: AppText.credentialAlreadyInUse.tr());
      case 'user-mismatch':
        return FirebaseErrors(errorMessage: AppText.userMismatch.tr());
      case 'account-exists-with-different-credential':
        return FirebaseErrors(
            errorMessage: AppText.accountExistsWithDifferentCredential.tr());
      case 'operation-not-allowed':
        return FirebaseErrors(errorMessage: AppText.operationNotAllowed.tr());
      case 'expired-action-code':
        return FirebaseErrors(errorMessage: AppText.expiredActionCode.tr());
      case 'invalid-action-code':
        return FirebaseErrors(errorMessage: AppText.invalidActionCode.tr());
      case 'missing-action-code':
        return FirebaseErrors(errorMessage: AppText.missingActionCode.tr());
      case 'user-token-expired':
        return FirebaseErrors(errorMessage: AppText.userTokenExpired.tr());
      case 'wrong-password':
        return FirebaseErrors(errorMessage: AppText.wrongPassword.tr());
      case 'user-token-revoked':
        return FirebaseErrors(errorMessage: AppText.userTokenRevoked.tr());
      case 'invalid-message-payload':
        return FirebaseErrors(errorMessage: AppText.invalidMessagePayload.tr());
      case 'invalid-sender':
        return FirebaseErrors(errorMessage: AppText.invalidSender.tr());
      case 'invalid-recipient-email':
        return FirebaseErrors(errorMessage: AppText.invalidRecipientEmail.tr());
      case 'missing-iframe-start':
        return FirebaseErrors(errorMessage: AppText.missingIframeStart.tr());
      case 'missing-iframe-end':
        return FirebaseErrors(errorMessage: AppText.missingIframeEnd.tr());
      case 'missing-iframe-src':
        return FirebaseErrors(errorMessage: AppText.missingIframeSrc.tr());
      case 'auth-domain-config-required':
        return FirebaseErrors(
            errorMessage: AppText.authDomainConfigRequired.tr());
      case 'missing-app-credential':
        return FirebaseErrors(errorMessage: AppText.missingAppCredential.tr());
      case 'invalid-app-credential':
        return FirebaseErrors(errorMessage: AppText.invalidAppCredential.tr());
      case 'session-cookie-expired':
        return FirebaseErrors(errorMessage: AppText.sessionCookieExpired.tr());
      case 'uid-already-exists':
        return FirebaseErrors(errorMessage: AppText.uidAlreadyExists.tr());
      case 'invalid-cordova-configuration':
        return FirebaseErrors(
            errorMessage: AppText.invalidCordovaConfiguration.tr());
      case 'app-deleted':
        return FirebaseErrors(errorMessage: AppText.appDeleted.tr());
      case 'user-token-mismatch':
        return FirebaseErrors(errorMessage: AppText.userTokenMismatch.tr());
      case 'web-storage-unsupported':
        return FirebaseErrors(errorMessage: AppText.webStorageUnsupported.tr());
      case 'invalid-credential':
        return FirebaseErrors(errorMessage: AppText.invalidCredential.tr());
      case 'app-not-authorized':
        return FirebaseErrors(errorMessage: AppText.appNotAuthorized.tr());
      case 'keychain-error':
        return FirebaseErrors(errorMessage: AppText.keychainError.tr());
      case 'internal-error':
        return FirebaseErrors(errorMessage: AppText.internalError.tr());
      case 'INVALID_LOGIN_CREDENTIALS':
        return FirebaseErrors(
            errorMessage: AppText.invalidLoginCredentials.tr());
      default:
        return FirebaseErrors(errorMessage: AppText.unknownAuthError.tr());
    }
  }

  factory FirebaseErrors.firebaseExceptions(FirebaseException e) {
    switch (e.code) {
      case 'unknown':
        return FirebaseErrors(errorMessage: AppText.unknownFirebaseError.tr());
      case 'invalid-custom-token':
        return FirebaseErrors(errorMessage: AppText.invalidCustomToken.tr());
      case 'custom-token-mismatch':
        return FirebaseErrors(errorMessage: AppText.customTokenMismatch.tr());
      case 'user-disabled':
        return FirebaseErrors(errorMessage: AppText.userDisabled.tr());
      case 'user-not-found':
        return FirebaseErrors(errorMessage: AppText.userNotFound.tr());
      case 'invalid-email':
        return FirebaseErrors(errorMessage: AppText.invalidEmail.tr());
      case 'email-already-in-use':
        return FirebaseErrors(errorMessage: AppText.emailAlreadyInUse.tr());
      case 'wrong-password':
        return FirebaseErrors(errorMessage: AppText.wrongPassword.tr());
      case 'weak-password':
        return FirebaseErrors(errorMessage: AppText.weakPassword.tr());
      case 'provider-already-linked':
        return FirebaseErrors(errorMessage: AppText.providerAlreadyLinked.tr());
      case 'operation-not-allowed':
        return FirebaseErrors(errorMessage: AppText.operationNotAllowed.tr());
      case 'invalid-credential':
        return FirebaseErrors(errorMessage: AppText.invalidCredential.tr());
      case 'invalid-verification-code':
        return FirebaseErrors(
            errorMessage: AppText.invalidVerificationCode.tr());
      case 'invalid-verification-id':
        return FirebaseErrors(errorMessage: AppText.invalidVerificationId.tr());
      case 'captcha-check-failed':
        return FirebaseErrors(errorMessage: AppText.captchaCheckFailed.tr());
      case 'app-not-authorized':
        return FirebaseErrors(errorMessage: AppText.appNotAuthorized.tr());
      case 'keychain-error':
        return FirebaseErrors(errorMessage: AppText.keychainError.tr());
      case 'internal-error':
        return FirebaseErrors(errorMessage: AppText.internalError.tr());
      case 'invalid-app-credential':
        return FirebaseErrors(errorMessage: AppText.invalidAppCredential.tr());
      case 'user-mismatch':
        return FirebaseErrors(errorMessage: AppText.userMismatch.tr());
      case 'requires-recent-login':
        return FirebaseErrors(errorMessage: AppText.requiresRecentLogin.tr());
      case 'quota-exceeded':
        return FirebaseErrors(errorMessage: AppText.quotaExceeded.tr());
      case 'account-exists-with-different-credential':
        return FirebaseErrors(
            errorMessage: AppText.accountExistsWithDifferentCredential.tr());
      case 'missing-iframe-start':
        return FirebaseErrors(errorMessage: AppText.missingIframeStart.tr());
      case 'missing-iframe-end':
        return FirebaseErrors(errorMessage: AppText.missingIframeEnd.tr());
      case 'missing-iframe-src':
        return FirebaseErrors(errorMessage: AppText.missingIframeSrc.tr());
      case 'auth-domain-config-required':
        return FirebaseErrors(
            errorMessage: AppText.authDomainConfigRequired.tr());
      case 'missing-app-credential':
        return FirebaseErrors(errorMessage: AppText.missingAppCredential.tr());
      case 'session-cookie-expired':
        return FirebaseErrors(errorMessage: AppText.sessionCookieExpired.tr());
      case 'uid-already-exists':
        return FirebaseErrors(errorMessage: AppText.uidAlreadyExists.tr());
      case 'web-storage-unsupported':
        return FirebaseErrors(errorMessage: AppText.webStorageUnsupported.tr());
      case 'app-deleted':
        return FirebaseErrors(errorMessage: AppText.appDeleted.tr());
      case 'user-token-mismatch':
        return FirebaseErrors(errorMessage: AppText.userTokenMismatch.tr());
      case 'invalid-message-payload':
        return FirebaseErrors(errorMessage: AppText.invalidMessagePayload.tr());
      case 'invalid-sender':
        return FirebaseErrors(errorMessage: AppText.invalidSender.tr());
      case 'invalid-recipient-email':
        return FirebaseErrors(errorMessage: AppText.invalidRecipientEmail.tr());
      case 'missing-action-code':
        return FirebaseErrors(errorMessage: AppText.missingActionCode.tr());
      case 'user-token-expired':
        return FirebaseErrors(errorMessage: AppText.userTokenExpired.tr());
      case 'INVALID_LOGIN_CREDENTIALS':
        return FirebaseErrors(
            errorMessage: AppText.invalidLoginCredentials.tr());
      case 'expired-action-code':
        return FirebaseErrors(errorMessage: AppText.expiredActionCode.tr());
      case 'invalid-action-code':
        return FirebaseErrors(errorMessage: AppText.invalidActionCode.tr());
      case 'credential-already-in-use':
        return FirebaseErrors(
            errorMessage: AppText.credentialAlreadyInUse.tr());
      default:
        return FirebaseErrors(errorMessage: AppText.unknownAuthError.tr());
    }
  }
}

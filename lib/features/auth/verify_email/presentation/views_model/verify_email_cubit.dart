import 'dart:async';

import 'package:evently_app/core/utils/services/firestore_services/firestore_services.dart';
import 'package:evently_app/features/auth/verify_email/data/repositories/verifiy_email_repository.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views_model/verify_email_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitial()) {
    onInit();
  }
  final String? email = FirebaseAuth.instance.currentUser?.email;

  void onInit() {
    sendEmailVerification();
    autoCheckEmailVerificationStatus();
  }

  // Send Email Verification link
  Future<void> sendEmailVerification() async {
    emit(SendEmailVerificationLoadingState());
    var result = await VerifyEmailRepository.sendEmailVerification();
    result.fold(
      (failure) => emit(
        SendEmailVerificationFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (emailSent) => emit(SendEmailVerificationSuccessState()),
    );
  }

  // logout
  Future<void> logout() async {
    var result = await VerifyEmailRepository.logout();
    result.fold(
      (failure) => emit(
        LogoutFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (emailSent) => emit(LogoutSuccessState()),
    );
  }

  // Timer to automatically redirect on Email Verification Success Screen
  Future<void> autoCheckEmailVerificationStatus() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          emit(EmailVerifiedState());
        }
      },
    );
  }

  // Manually check if email verified
  Future<void> manuallyCheckEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      emit(EmailVerifiedState());
    }
  }

  Future<void> getUserData() async {
    var result = await VerifyEmailRepository.getUserData();
    result.fold(
      (failure) => emit(
        FetchUserDataFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (userData) => FireStoreServices.currentUserData = userData,
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/cache/shared_preferences_helper.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/constants/const_keys.dart';
import 'package:evently_app/features/profile/data/repositories/profile_repository.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    onInit();
  }

  final List<String> languages = [
    AppText.arabic,
    AppText.english,
  ];
  final List<String> theme = [
    AppText.light,
    AppText.dark,
  ];
  late String currentTheme;
  late String currentLanguage;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

  void onInit() {
    currentTheme = SharedPreferencesHelper.getBool(key: ConstKeys.isDarkTheme)
        ? theme[1]
        : theme[0];
    currentLanguage =
        SharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage)
            ? languages[0]
            : languages[1];
  }

  Future<void> changeTheme({
    required String? themeValue,
    required BuildContext context,
  }) async {
    final controller = BlocProvider.of<StartCubit>(context);
    if (themeValue == theme[0] && currentTheme != theme[0]) {
      currentTheme = theme[0];
      await controller.onThemeIndexChanged(index: 0);
    } else if (themeValue == theme[1] && currentTheme != theme[1]) {
      currentTheme = theme[1];
      await controller.onThemeIndexChanged(index: 1);
    }
  }

  Future<void> changeLanguage({
    required String? languageValue,
    required BuildContext context,
  }) async {
    final controller = BlocProvider.of<StartCubit>(context);
    if (languageValue == languages[0] && currentLanguage != languages[0]) {
      currentLanguage = languages[0];
      context.setLocale(const Locale("ar"));
      await controller.onLanguageIndexChanged(index: 1);
    } else if (languageValue == languages[1] &&
        currentLanguage != languages[1]) {
      currentLanguage = languages[1];
      context.setLocale(const Locale("en"));
      await controller.onLanguageIndexChanged(index: 0);
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    var result = await ProfileRepository.logout();
    result.fold(
      (failure) => emit(
        LogoutFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (logoutSuccess) => emit(LogoutSuccessState()),
    );
  }

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    var deleteRelativeAccountDataResult =
        await ProfileRepository.deleteUserRelatedEvents(userId: userId);
    deleteRelativeAccountDataResult.fold(
      (failure) => emit(
        DeleteAccountFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (relevantDataDeletedSuccessfully) async {
        var deleteAccountDataResult =
            await ProfileRepository.deleteUserAccount(userId: userId);
        deleteAccountDataResult.fold(
          (failure) => emit(
            DeleteAccountFailureState(
              errorMessage: failure.errorMessage,
            ),
          ),
          (allDeletedSuccessfully) => emit(
            DeleteAccountSuccessState(),
          ),
        );
      },
    );
  }
}

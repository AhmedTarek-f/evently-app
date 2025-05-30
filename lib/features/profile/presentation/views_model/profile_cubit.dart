import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/cache/shared_preferences_helper.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/constants/const_keys.dart';
import 'package:evently_app/features/profile/data/repositories/profile_repository.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    onInit();
  }

  final List<String> languages = [
    AppText.arabic.tr(),
    AppText.english.tr(),
  ];
  final List<String> theme = [
    AppText.light.tr(),
    AppText.dark.tr(),
  ];
  late String currentTheme;
  late String currentLanguage;

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
      await controller.onLanguageIndexChanged(index: 1);
    } else if (languageValue == languages[1] &&
        currentLanguage != languages[1]) {
      currentLanguage = languages[1];
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
}

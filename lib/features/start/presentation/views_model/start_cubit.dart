import 'package:evently_app/core/cache/shared_preferences_helper.dart';
import 'package:evently_app/core/constants/const_keys.dart';
import 'package:evently_app/features/auth/login/presentation/views/login_view.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views/verify_email_view.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views/evently_bottom_navigation_view.dart';
import 'package:evently_app/features/start/presentation/views/start_view.dart';
import 'package:evently_app/features/start/presentation/views_model/start_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit() : super(StartInitial()) {
    onInit();
  }
  late int languageSelectedIndex;
  late int themeSelectedIndex;
  late bool isDarkMode;
  late bool isArLanguage;
  late bool isHomeScreen;
  late final String redirectedScreen;
  final _user = FirebaseAuth.instance.currentUser;

  void onInit() {
    isDarkMode = SharedPreferencesHelper.getBool(key: ConstKeys.isDarkTheme);
    isArLanguage = SharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage);
    isHomeScreen = SharedPreferencesHelper.getBool(key: ConstKeys.isHomeScreen);
    themeSelectedIndex = isDarkMode ? 1 : 0;
    languageSelectedIndex = isArLanguage ? 1 : 0;
    screenRedirect();
  }

  Future<void> onLanguageIndexChanged({required int index}) async {
    if (languageSelectedIndex != index && index == 0) {
      languageSelectedIndex = index;
      await SharedPreferencesHelper.saveBool(
          key: ConstKeys.isArLanguage, value: false);
      isArLanguage = false;
      emit(const ChangeLanguageIndexState(selectedLang: "en"));
    } else if (languageSelectedIndex != index && index == 1) {
      languageSelectedIndex = index;
      await SharedPreferencesHelper.saveBool(
          key: ConstKeys.isArLanguage, value: true);
      isArLanguage = true;
      emit(const ChangeLanguageIndexState(selectedLang: "ar"));
    }
  }

  Future<void> onThemeIndexChanged({required int index}) async {
    if (themeSelectedIndex != index && index == 0) {
      themeSelectedIndex = index;
      await SharedPreferencesHelper.saveBool(
          key: ConstKeys.isDarkTheme, value: false);
      isDarkMode = false;
      emit(ChangeThemeIndexState());
    } else if (themeSelectedIndex != index && index == 1) {
      themeSelectedIndex = index;
      await SharedPreferencesHelper.saveBool(
          key: ConstKeys.isDarkTheme, value: true);
      isDarkMode = true;
      emit(ChangeThemeIndexState());
    }
  }

  void screenRedirect() {
    if (isHomeScreen) {
      if (_user != null) {
        if (_user.emailVerified) {
          redirectedScreen = EventlyBottomNavigationView.routeName;
        } else {
          redirectedScreen = VerifyEmailView.routeName;
        }
      } else {
        redirectedScreen = LoginView.routeName;
      }
    } else {
      redirectedScreen = StartView.routeName;
    }
  }
}

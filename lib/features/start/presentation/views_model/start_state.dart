sealed class StartState {}

final class StartInitial extends StartState {}

final class ChangeLanguageIndexState extends StartState {
  ChangeLanguageIndexState({required this.selectedLang});
  final String selectedLang;
}

final class ChangeThemeIndexState extends StartState {}

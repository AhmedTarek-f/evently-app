sealed class StartState {
  const StartState();
}

final class StartInitial extends StartState {}

final class ChangeLanguageIndexState extends StartState {
  const ChangeLanguageIndexState({required this.selectedLang});
  final String selectedLang;
}

final class ChangeThemeIndexState extends StartState {}

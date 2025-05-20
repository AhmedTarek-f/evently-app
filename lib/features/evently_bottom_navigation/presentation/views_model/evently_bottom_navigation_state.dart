import 'package:equatable/equatable.dart';

sealed class EventlyBottomNavigationState extends Equatable {
  const EventlyBottomNavigationState({required this.tapIndex});
  final int tapIndex;
}

final class EventlyBottomNavigationInitial
    extends EventlyBottomNavigationState {
  const EventlyBottomNavigationInitial({required super.tapIndex});

  @override
  List<Object?> get props => [super.tapIndex];
}

final class ChangeTapState extends EventlyBottomNavigationState {
  const ChangeTapState({required super.tapIndex});

  @override
  List<Object?> get props => [super.tapIndex];
}

final class FetchUserDataSuccessState extends EventlyBottomNavigationState {
  const FetchUserDataSuccessState({required super.tapIndex});

  @override
  List<Object?> get props => [super.tapIndex];
}

final class FetchUserDataLoadingState extends EventlyBottomNavigationState {
  const FetchUserDataLoadingState({required super.tapIndex});

  @override
  List<Object?> get props => [super.tapIndex];
}

final class FetchUserDataFailureState extends EventlyBottomNavigationState {
  const FetchUserDataFailureState({
    required super.tapIndex,
    required this.errorMessage,
  });
  final String errorMessage;
  @override
  List<Object?> get props => [super.tapIndex];
}

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

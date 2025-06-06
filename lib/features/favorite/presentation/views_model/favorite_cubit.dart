import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/favorite/data/repositories/favorite_repository.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(BuildContext context)
      : _context = context,
        super(FavoriteInitial()) {
    onInit();
  }
  final BuildContext _context;
  List<EventModel> favoriteEvents = [];
  List<EventModel> searchFavoriteEventsList = [];
  late final TextEditingController favoriteSearchField;

  void onInit() {
    getFavoriteEvent();
    favoriteSearchField = TextEditingController();
  }

  void getFavoriteEvent() {
    favoriteEvents = FavoriteRepository.getFavoriteEvents(
      favoriteEventIds: BlocProvider.of<EventlyBottomNavigationCubit>(_context)
              .currentUserData
              ?.favoriteEvents ??
          [],
    );
  }

  List<String> getEventDate({required DateTime date, required String locale}) {
    String day = DateFormat("dd", locale).format(date);
    String month = DateFormat("MMM", locale).format(date).substring(0, 3);
    return <String>[day, month];
  }

  Future<void> deleteFavoriteEvent({
    required UserModel userData,
    required String eventId,
  }) async {
    emit(DeleteFavoriteEventLoadingState(eventId: eventId));
    List<String> copyOfFavoriteEvents = [];
    copyOfFavoriteEvents.addAll(userData.favoriteEvents);
    copyOfFavoriteEvents.removeWhere((event) => event == eventId);
    var result = await FavoriteRepository.updateFavoriteEvents(
      userId: userData.id,
      favoriteEventsList: copyOfFavoriteEvents,
    );
    result.fold(
      (failure) => emit(
        DeleteFavoriteEventFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        userData.favoriteEvents.removeWhere((event) => event == eventId);
        if (searchFavoriteEventsList.any((event) => event.eventId == eventId)) {
          searchFavoriteEventsList
              .removeWhere((event) => event.eventId == eventId);
        }
        favoriteEvents.removeWhere((event) => event.eventId == eventId);
        emit(DeleteFavoriteEventSuccessState());
      },
    );
  }

  void favoriteEventsSearch({required String eventTitle}) {
    searchFavoriteEventsList.clear();
    if ((eventTitle.isNotEmpty) && eventTitle.trim() != "") {
      final List<EventModel> matchedList = favoriteEvents
          .where((event) => event.eventTitle!
              .toLowerCase()
              .contains(eventTitle.toLowerCase()))
          .toList();
      searchFavoriteEventsList.addAll(matchedList);
    }
    emit(ChangeSearchFieldValueState());
  }

  @override
  Future<void> close() {
    favoriteSearchField.dispose();
    return super.close();
  }
}

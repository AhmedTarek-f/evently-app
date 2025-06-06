import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/category_item_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/home/data/repositories/home_repository.dart';
import 'package:evently_app/features/home/presentation/views_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    onInit();
  }
  StreamSubscription<Either<Failure, List<EventModel>>>? _eventsSubscription;
  late CategoryItemModel selectedCategoryItem;
  List<CategoryItemModel> eventCategoriesList = [];
  int currentCategoryIndex = 0;
  List<List<EventModel>> eventTapsList = [];
  List<EventModel> sportEvents = [];
  List<EventModel> birthdayEvents = [];
  List<EventModel> meetingEvents = [];
  List<EventModel> gamingEvents = [];
  List<EventModel> eatingEvents = [];
  List<EventModel> holidayEvents = [];
  List<EventModel> exhibitionEvents = [];
  List<EventModel> workShopEvents = [];
  List<EventModel> bookClubEvents = [];
  void onInit() {
    initializeEventCategoriesList();
    getAllEvents();
  }

  void initializeEventCategoriesList() {
    eventCategoriesList.addAll(EventlyMethodsHelper.eventCategoriesList);
    eventCategoriesList.insert(
      0,
      const CategoryItemModel(
        categoryName: AppText.all,
        categoryIcon: AppIcons.all,
      ),
    );
    selectedCategoryItem = eventCategoriesList[0];
  }

  void getAllEvents() {
    emit(FetchEventsLoadingState());

    _eventsSubscription?.cancel();
    _eventsSubscription = HomeRepository.fetchAllEvents().listen((result) {
      result.fold(
        (failure) => emit(
          FetchEventsFailureState(errorMessage: failure.errorMessage),
        ),
        (allEventsData) {
          EventlyMethodsHelper.allEvents
            ..clear()
            ..addAll(allEventsData);
          initializeEventTapsList();
          emit(FetchEventsSuccessState());
        },
      );
    });
  }

  void initializeEventTapsList() {
    eventTapsList.clear();
    sportEvents.clear();
    birthdayEvents.clear();
    meetingEvents.clear();
    gamingEvents.clear();
    eatingEvents.clear();
    holidayEvents.clear();
    exhibitionEvents.clear();
    workShopEvents.clear();
    bookClubEvents.clear();
    for (var event in EventlyMethodsHelper.allEvents) {
      switch (event.eventCategory) {
        case "sport":
          sportEvents.add(event);
        case "birthday":
          birthdayEvents.add(event);
        case "meeting":
          meetingEvents.add(event);
        case "gaming":
          gamingEvents.add(event);
        case "eating":
          eatingEvents.add(event);
        case "holiday":
          holidayEvents.add(event);
        case "exhibition":
          exhibitionEvents.add(event);
        case "workShop":
          workShopEvents.add(event);
        case "bookClub":
          bookClubEvents.add(event);
      }
    }
    eventTapsList.add(EventlyMethodsHelper.allEvents);
    eventTapsList.add(bookClubEvents);
    eventTapsList.add(sportEvents);
    eventTapsList.add(birthdayEvents);
    eventTapsList.add(eatingEvents);
    eventTapsList.add(gamingEvents);
    eventTapsList.add(meetingEvents);
    eventTapsList.add(holidayEvents);
    eventTapsList.add(workShopEvents);
    eventTapsList.add(exhibitionEvents);
  }

  void getCurrentCategorySelectedTap({required int tapIndex}) {
    if (currentCategoryIndex != tapIndex) {
      currentCategoryIndex = tapIndex;
      selectedCategoryItem = eventCategoriesList[currentCategoryIndex];
      emit(ChangeSelectedCategoryState());
    }
  }

  Future<void> toggleFavorite({
    required UserModel userData,
    required String eventId,
  }) async {
    emit(ToggleFavoriteLoadingState(eventId: eventId));
    List<String> copyOfUserFavoriteEvents = [];
    copyOfUserFavoriteEvents.addAll(userData.favoriteEvents);
    if (copyOfUserFavoriteEvents.contains(eventId)) {
      copyOfUserFavoriteEvents.removeWhere(
        (event) => event == eventId,
      );
    } else {
      copyOfUserFavoriteEvents.add(eventId);
    }
    var result = await HomeRepository.updateFavoriteEvents(
      userId: userData.id,
      favoriteEventsList: copyOfUserFavoriteEvents,
    );
    result.fold(
      (failure) => emit(
        ToggleFavoriteFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        if (userData.favoriteEvents.contains(eventId)) {
          userData.favoriteEvents.removeWhere(
            (event) => event == eventId,
          );
        } else {
          userData.favoriteEvents.add(eventId);
        }
        emit(ToggleFavoriteSuccessState());
      },
    );
  }

  List<String> getEventDate({required DateTime date, required String locale}) {
    String day = DateFormat("dd", locale).format(date);
    String month = DateFormat("MMM", locale).format(date).substring(0, 3);
    return <String>[day, month];
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }
}

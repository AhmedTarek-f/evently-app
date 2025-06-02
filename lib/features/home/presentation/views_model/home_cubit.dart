import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
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
    initializeEventTapsList();
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

  Future<void> initializeEventTapsList() async {
    bool isAlreadyCached = EventlyMethodsHelper.allEvents.isNotEmpty;
    await getAllEvents();
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
    if (isAlreadyCached) emit(FetchCachedEventsState());
  }

  Future<void> reloadEventTapsList() async {
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
    await _reloadAllEvents();
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

  Future<void> getAllEvents() async {
    if (EventlyMethodsHelper.allEvents.isNotEmpty) {
      return;
    } else {
      emit(FetchEventsLoadingState());
      var result = await HomeRepository.fetchAllEvents();
      result.fold(
        (failure) => emit(
          FetchEventsFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (allEventsData) {
          EventlyMethodsHelper.allEvents.addAll(allEventsData);
          emit(FetchEventsSuccessState());
        },
      );
    }
  }

  Future<void> _reloadAllEvents() async {
    emit(FetchEventsLoadingState());
    var result = await HomeRepository.fetchAllEvents();
    result.fold(
      (failure) => emit(
        FetchEventsFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (allEventsData) {
        EventlyMethodsHelper.allEvents.clear();
        EventlyMethodsHelper.allEvents.addAll(allEventsData);
        emit(FetchEventsSuccessState());
      },
    );
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

  List<String> getEventDate({required DateTime date}) {
    String day = DateFormat("dd").format(date);
    String month = DateFormat("MMM").format(date).substring(0, 3);
    return <String>[day, month];
  }
}

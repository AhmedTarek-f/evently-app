import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/category_item_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/create_event/data/repositories/create_event_repository.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit() : super(CreateEventInitial()) {
    onInit();
  }

  CategoryItemModel selectedCategoryItem =
      EventlyMethodsHelper.eventCategoriesList[0];
  late final TextEditingController eventTitleController;
  late final TextEditingController eventDescriptionController;
  late final GlobalKey<FormState> createEventFormKey;
  late final Uuid uniqueIdCreator;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? pickedDate;
  String? pickedTime;
  String? locationLang;
  String? locationLat;
  bool isLoading = false;

  void onInit() {
    createEventFormKey = GlobalKey<FormState>();
    eventTitleController = TextEditingController();
    eventDescriptionController = TextEditingController();
    uniqueIdCreator = const Uuid();
  }

  void changeSelectedCategory({required CategoryItemModel categoryItem}) {
    if (selectedCategoryItem.categoryName != categoryItem.categoryName) {
      selectedCategoryItem = categoryItem;
      emit(ChangeSelectedCategoryState());
    }
  }

  void formatDate({required DateTime date}) {
    pickedDate = DateFormat('dd/MM/yyyy').format(date);
    emit(PickingDateState());
  }

  void formatTime({required TimeOfDay time}) {
    final now = DateTime.now();
    final dateNow = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    pickedTime = DateFormat('hh:mma').format(dateNow);
    emit(PickingTimeState());
  }

  TimeOfDay parseTimeOfDay(String timeString) {
    final DateFormat format = DateFormat('hh:mma');
    final DateTime dateTime = format.parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  DateTime parseDate(String dateString) {
    final DateFormat format = DateFormat('dd/MM/yyyy');
    return format.parse(dateString);
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  Future<void> addEvent() async {
    if (createEventFormKey.currentState!.validate()) {
      if (pickedDate == null) {
        emit(PickingDateValidationState());
      } else if (pickedTime == null) {
        emit(PickingTimeValidationState());
      } else {
        isLoading = true;
        emit(CreateEventLoadingState());
        final String eventId = uniqueIdCreator.v4();
        var result = await CreateEventRepository.createEvent(
          eventData: EventModel(
            eventCreatorId: FirebaseAuth.instance.currentUser?.uid,
            eventId: eventId,
            eventCategory: selectedCategoryItem.categoryName,
            eventTitle: eventTitleController.text,
            eventDescription: eventDescriptionController.text,
            eventDate: pickedDate,
            eventTime: pickedTime,
            eventLocationLang: locationLang,
            eventLocationLat: locationLat,
          ),
        );
        result.fold(
          (failure) {
            isLoading = false;
            emit(
              CreateEventFailureState(
                errorMessage: failure.errorMessage,
              ),
            );
          },
          (success) => emit(
            CreateEventSuccessState(),
          ),
        );
      }
    } else {
      enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    eventTitleController.dispose();
    eventDescriptionController.dispose();
    return super.close();
  }
}

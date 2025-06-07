import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/category_item_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/create_event/data/repositories/create_event_repository.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit() : super(CreateEventInitial()) {
    onInit();
  }

  CategoryItemModel selectedCategoryItem =
      EventlyMethodsHelper.eventCategoriesList[0];
  late final TextEditingController eventTitleController;
  late final TextEditingController eventDescriptionController;
  late final GlobalKey<FormState> createEventFormKey;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? pickedDate;
  String? pickedTime;
  String? locationLong;
  String? locationLat;
  String? country;
  String? city;
  DateTime? originalPickedDate;
  bool isLoading = false;

  void onInit() {
    createEventFormKey = GlobalKey<FormState>();
    eventTitleController = TextEditingController();
    eventDescriptionController = TextEditingController();
  }

  void changeSelectedCategory({required CategoryItemModel categoryItem}) {
    if (selectedCategoryItem.categoryName != categoryItem.categoryName) {
      selectedCategoryItem = categoryItem;
      emit(ChangeSelectedCategoryState());
    }
  }

  void formatDate({required DateTime date, required String locale}) {
    originalPickedDate = date;
    pickedDate = DateFormat(
      'dd/MM/yyyy',
      locale,
    ).format(date);
    emit(PickingDateState());
  }

  void formatTime({required TimeOfDay time, required String locale}) {
    final now = DateTime.now();
    final dateNow = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    pickedTime = DateFormat(
      'hh:mma',
      locale,
    ).format(dateNow);
    emit(PickingTimeState());
  }

  TimeOfDay parseTimeOfDay({
    required String timeString,
    required String locale,
  }) {
    final DateFormat format = DateFormat(
      'hh:mma',
      locale,
    );
    final DateTime dateTime = format.parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  DateTime parseDate({
    required String dateString,
    required String locale,
  }) {
    final DateFormat format = DateFormat(
      'dd/MM/yyyy',
      locale,
    );
    return format.parse(dateString);
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  Future<void> selectEventLocation({required LatLng? eventLocation}) async {
    if (eventLocation != null) {
      emit(SelectEventLocationLoadingState());
      var result = await CreateEventRepository.getEventLocationName(
        eventLocation: eventLocation,
      );
      result.fold(
        (failure) => emit(
          SelectEventLocationFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (locationName) {
          locationLat = eventLocation.latitude.toStringAsFixed(3);
          locationLong = eventLocation.longitude.toStringAsFixed(3);
          country = locationName.first.country;
          city = locationName.first.locality;
          emit(SelectEventLocationSuccessState());
        },
      );
    }
  }

  Future<void> addEvent({required String locale}) async {
    if (createEventFormKey.currentState!.validate()) {
      if (pickedDate == null) {
        emit(PickingDateValidationState());
      } else if (pickedTime == null) {
        emit(PickingTimeValidationState());
      } else if (country == null ||
          locationLat == null ||
          locationLong == null) {
        emit(EventLocationValidationState());
      } else {
        isLoading = true;
        emit(CreateEventLoadingState());
        final originalPickedTime = parseTimeOfDay(
          timeString: pickedTime!,
          locale: locale,
        );
        final originalPickedDateWithTime = DateTime(
          originalPickedDate!.year,
          originalPickedDate!.month,
          originalPickedDate!.day,
          originalPickedTime.hour,
          originalPickedTime.minute,
        );
        var result = await CreateEventRepository.createEvent(
          eventData: EventModel(
            eventCreatorId: FirebaseAuth.instance.currentUser?.uid,
            eventCategory: selectedCategoryItem.categoryName,
            eventTitle: eventTitleController.text,
            eventDescription: eventDescriptionController.text,
            eventDate: originalPickedDateWithTime,
            eventLocationLong: locationLong,
            eventLocationLat: locationLat,
            eventCountry: country,
            eventCity: city,
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

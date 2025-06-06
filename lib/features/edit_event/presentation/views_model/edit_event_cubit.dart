import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/category_item_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/edit_event/data/repositories/edit_event_repository.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_state.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EditEventCubit extends Cubit<EditEventState> {
  EditEventCubit(EventDetailsCubit eventDetailsCubit, String currentLocale)
      : eventDetailsController = eventDetailsCubit,
        _locale = currentLocale,
        super(EditEventInitial()) {
    onInit();
  }
  final EventDetailsCubit eventDetailsController;
  CategoryItemModel selectedCategoryItem =
      EventlyMethodsHelper.eventCategoriesList[0];
  final String _locale;
  late final TextEditingController eventTitleController;
  late final TextEditingController eventDescriptionController;
  late final GlobalKey<FormState> editEventFormKey;
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
    editEventFormKey = GlobalKey<FormState>();
    eventTitleController = TextEditingController();
    eventTitleController.text = eventDetailsController.eventData.eventTitle!;
    eventDescriptionController = TextEditingController();
    eventDescriptionController.text =
        eventDetailsController.eventData.eventDescription!;
    originalPickedDate = eventDetailsController.eventData.eventDate;
    initialSelectedCategory();
    initialFormatDate();
    initialFormatTime();
    initialLocation();
  }

  void initialSelectedCategory() {
    locationLat = eventDetailsController.eventData.eventLocationLat;
    locationLong = eventDetailsController.eventData.eventLocationLong;
    selectedCategoryItem = EventlyMethodsHelper.eventCategoriesList.firstWhere(
      (event) =>
          event.categoryName == eventDetailsController.eventData.eventCategory,
    );
  }

  void initialFormatDate() {
    pickedDate = DateFormat('dd/MM/yyyy', _locale).format(
      originalPickedDate ?? DateTime.now(),
    );
  }

  void initialFormatTime() {
    pickedTime = DateFormat('hh:mma', _locale).format(
      originalPickedDate ?? DateTime.now(),
    );
  }

  void initialLocation() {
    country = eventDetailsController.eventData.eventCountry;
    city = eventDetailsController.eventData.eventCity;
  }

  void changeSelectedCategory({required CategoryItemModel categoryItem}) {
    if (selectedCategoryItem.categoryName != categoryItem.categoryName) {
      selectedCategoryItem = categoryItem;
      emit(ChangeSelectedCategoryState());
    }
  }

  void formatDate({required DateTime date}) {
    originalPickedDate = date;
    pickedDate = DateFormat(
      'dd/MM/yyyy',
      _locale,
    ).format(date);
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
    pickedTime = DateFormat(
      'hh:mma',
      _locale,
    ).format(dateNow);
    emit(PickingTimeState());
  }

  TimeOfDay parseTimeOfDay(String timeString) {
    final DateFormat format = DateFormat('hh:mma', _locale);
    final DateTime dateTime = format.parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  DateTime parseDate(String dateString) {
    final DateFormat format = DateFormat('dd/MM/yyyy', _locale);
    return format.parse(dateString);
  }

  void enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  Future<void> selectEventLocation({required LatLng? eventLocation}) async {
    if (eventLocation != null) {
      emit(SelectEventLocationLoadingState());
      var result = await EditEventRepository.getEventLocationName(
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

  Future<void> updateEvent() async {
    final eventData = eventDetailsController.eventData;
    if (editEventFormKey.currentState!.validate()) {
      if (pickedDate == null) {
        emit(PickingDateValidationState());
      } else if (pickedTime == null) {
        emit(PickingTimeValidationState());
      } else if (country == null ||
          locationLat == null ||
          locationLong == null) {
        emit(EventLocationValidationState());
      } else if (selectedCategoryItem.categoryName != eventData.eventCategory ||
          eventTitleController.text != eventData.eventTitle ||
          eventDescriptionController.text != eventData.eventDescription ||
          originalPickedDate?.year != eventData.eventDate?.year ||
          originalPickedDate?.month != eventData.eventDate?.month ||
          originalPickedDate?.day != eventData.eventDate?.day ||
          originalPickedDate?.hour != eventData.eventDate?.hour ||
          originalPickedDate?.minute != eventData.eventDate?.minute ||
          locationLong != eventData.eventLocationLong ||
          locationLat != eventData.eventLocationLat ||
          country != eventData.eventCountry ||
          city != eventData.eventCity) {
        isLoading = true;
        emit(EditEventLoadingState());
        final originalPickedTime = parseTimeOfDay(pickedTime!);
        final originalPickedDateWithTime = DateTime(
          originalPickedDate!.year,
          originalPickedDate!.month,
          originalPickedDate!.day,
          originalPickedTime.hour,
          originalPickedTime.minute,
        );
        final EventModel updatedEventData = EventModel(
          eventId: eventDetailsController.eventData.eventId,
          eventCreatorId: eventDetailsController.eventData.eventCreatorId,
          eventCategory: selectedCategoryItem.categoryName,
          eventTitle: eventTitleController.text,
          eventDescription: eventDescriptionController.text,
          eventDate: originalPickedDateWithTime,
          eventLocationLong: locationLong,
          eventLocationLat: locationLat,
          eventCountry: country,
          eventCity: city,
          participateUsers: eventDetailsController.eventData.participateUsers,
        );
        var result = await EditEventRepository.editEvent(
          eventData: updatedEventData,
        );
        result.fold(
          (failure) {
            isLoading = false;
            emit(
              EditEventFailureState(
                errorMessage: failure.errorMessage,
              ),
            );
          },
          (success) {
            eventDetailsController.eventData = updatedEventData;
            emit(
              EditEventSuccessState(),
            );
          },
        );
      } else {
        emit(NoChangeState());
      }
    } else {
      enableAutoValidateMode();
    }
  }

  void animateCameraToNewEventLocation() {
    final LatLng newPosition = LatLng(
      double.parse(eventDetailsController.eventData.eventLocationLat ?? "0"),
      double.parse(eventDetailsController.eventData.eventLocationLong ?? "0"),
    );
    CameraPosition cameraPosition =
        CameraPosition(target: newPosition, zoom: 15);
    eventDetailsController.googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    eventDetailsController.markers.add(
      Marker(
        markerId:
            MarkerId("event_marker${eventDetailsController.eventData.eventId}"),
        icon: eventDetailsController.customIcon,
        position: newPosition,
        infoWindow:
            InfoWindow(title: eventDetailsController.eventData.eventTitle),
      ),
    );
  }

  @override
  Future<void> close() {
    eventTitleController.dispose();
    eventDescriptionController.dispose();
    return super.close();
  }
}

import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/created_events/presentation/views_model/created_events_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreatedEventsCubit extends Cubit<CreatedEventsState> {
  CreatedEventsCubit() : super(CreatedEventsInitial()) {
    onInit();
  }

  List<EventModel> createdEventsList = [];

  onInit() {
    createdEventsList = fetchCreatedEvents();
  }

  List<String> getEventDate({
    required DateTime date,
    required String locale,
  }) {
    String day = DateFormat("dd", locale).format(date);
    String month = DateFormat("MMM", locale).format(date).substring(0, 3);
    return <String>[day, month];
  }

  List<EventModel> fetchCreatedEvents() {
    return EventlyMethodsHelper.allEvents
        .where(
          (event) =>
              event.eventCreatorId == FirebaseAuth.instance.currentUser!.uid,
        )
        .toList();
  }

  void resetCreatedEventsList() {
    createdEventsList.clear();
    createdEventsList.addAll(fetchCreatedEvents());
    emit(CreatedEventsListChangeState());
  }
}

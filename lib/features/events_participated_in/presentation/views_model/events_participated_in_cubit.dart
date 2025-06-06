import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/events_participated_in/presentation/views_model/events_participated_in_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventsParticipatedInCubit extends Cubit<EventsParticipatedInState> {
  EventsParticipatedInCubit() : super(EventsParticipatedInInitial()) {
    onInit();
  }

  List<EventModel> eventsParticipatedInList = [];

  onInit() {
    eventsParticipatedInList = fetchEventsParticipatedInList();
  }

  List<String> getEventDate({required DateTime date, required String locale}) {
    String day = DateFormat("dd", locale).format(date);
    String month = DateFormat("MMM", locale).format(date).substring(0, 3);
    return <String>[day, month];
  }

  List<EventModel> fetchEventsParticipatedInList() {
    return EventlyMethodsHelper.allEvents
        .where(
          (event) => event.participateUsers!
              .contains(FirebaseAuth.instance.currentUser!.uid),
        )
        .toList();
  }

  void resetEventsParticipatedInList() {
    eventsParticipatedInList.clear();
    eventsParticipatedInList.addAll(fetchEventsParticipatedInList());
    emit(EventsParticipatedInListChangeState());
  }
}

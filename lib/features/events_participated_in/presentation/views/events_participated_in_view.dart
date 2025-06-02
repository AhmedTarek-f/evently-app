import 'package:evently_app/features/events_participated_in/presentation/views/widgets/events_participated_in_app_bar.dart';
import 'package:evently_app/features/events_participated_in/presentation/views/widgets/events_participated_in_list.dart';
import 'package:flutter/material.dart';

class EventsParticipatedInView extends StatelessWidget {
  const EventsParticipatedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EventsParticipatedInAppBar(),
      body: EventsParticipatedInList(),
    );
  }
}

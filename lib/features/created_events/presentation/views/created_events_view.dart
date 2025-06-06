import 'package:evently_app/features/created_events/presentation/views/widgets/created_events_app_bar.dart';
import 'package:evently_app/features/created_events/presentation/views/widgets/created_events_list.dart';
import 'package:flutter/material.dart';

class CreatedEventsView extends StatelessWidget {
  const CreatedEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CreatedEventsAppBar(),
      body: CreatedEventsList(),
    );
  }
}

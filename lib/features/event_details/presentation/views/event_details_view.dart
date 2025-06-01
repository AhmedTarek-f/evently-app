import 'package:evently_app/features/event_details/presentation/views/widgets/event_details_app_bar.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_details_view_body.dart';
import 'package:flutter/material.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EventDetailsAppBar(),
      body: EventDetailsViewBody(),
    );
  }
}

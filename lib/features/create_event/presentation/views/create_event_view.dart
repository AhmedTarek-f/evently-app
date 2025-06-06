import 'package:evently_app/features/create_event/presentation/views/widgets/create_event_app_bar.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/create_event_view_body.dart';
import 'package:flutter/material.dart';

class CreateEventView extends StatelessWidget {
  static const String routeName = "CreateEventView";
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CreateEventAppBar(),
      body: CreateEventViewBody(),
    );
  }
}

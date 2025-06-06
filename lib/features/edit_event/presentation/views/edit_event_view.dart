import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_app_bar.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_view_body.dart';
import 'package:flutter/material.dart';

class EditEventView extends StatelessWidget {
  const EditEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EditEventAppBar(),
      body: EditEventViewBody(),
    );
  }
}

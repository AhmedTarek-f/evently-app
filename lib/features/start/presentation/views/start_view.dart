import 'package:evently_app/features/start/presentation/views/widgets/start_app_bar.dart';
import 'package:evently_app/features/start/presentation/views/widgets/start_view_body.dart';
import 'package:flutter/material.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StartAppBar(),
      body: StartViewBody(),
    );
  }
}

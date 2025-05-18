import 'package:evently_app/features/evently_bottom_navigation/presentation/views/widgets/evently_bottom_navigation_bar.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views/widgets/evently_floating_action_button.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventlyBottomNavigationView extends StatelessWidget {
  static const String routeName = "EventlyBottomNavigationView";
  const EventlyBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventlyBottomNavigationCubit>(context);
    return Scaffold(
      bottomNavigationBar: const EventlyBottomNavigationBar(),
      floatingActionButton: const EventlyFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocBuilder<EventlyBottomNavigationCubit,
          EventlyBottomNavigationState>(
        builder: (context, state) =>
            controller.eventlyNavigationList[state.tapIndex],
      ),
    );
  }
}

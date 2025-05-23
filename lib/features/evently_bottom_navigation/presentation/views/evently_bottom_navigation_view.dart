import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views/widgets/evently_bottom_navigation_bar.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views/widgets/evently_floating_action_button.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:evently_app/features/start/presentation/views_model/start_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventlyBottomNavigationView extends StatelessWidget {
  static const String routeName = "EventlyBottomNavigationView";
  const EventlyBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventlyBottomNavigationCubit>(context);
    return BlocListener<EventlyBottomNavigationCubit,
        EventlyBottomNavigationState>(
      listener: (context, state) {
        if (state is FetchUserDataFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        }
      },
      child: BlocBuilder<StartCubit, StartState>(
        buildWhen: (previous, current) =>
            current is ChangeLanguageIndexState ||
            current is ChangeThemeIndexState,
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: const EventlyBottomNavigationBar(),
          floatingActionButton: const EventlyFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: BlocBuilder<EventlyBottomNavigationCubit,
              EventlyBottomNavigationState>(
            builder: (context, state) =>
                controller.eventlyNavigationList[controller.currentTapIndex],
          ),
        ),
      ),
    );
  }
}

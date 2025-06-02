import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/animation_loader_widget.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:evently_app/features/events_participated_in/presentation/views/widgets/events_participated_in_card_list.dart';
import 'package:evently_app/features/events_participated_in/presentation/views_model/events_participated_in_cubit.dart';
import 'package:evently_app/features/events_participated_in/presentation/views_model/events_participated_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsParticipatedInList extends StatelessWidget {
  const EventsParticipatedInList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventsParticipatedInCubit>(context);
    return BlocListener<EventlyBottomNavigationCubit,
        EventlyBottomNavigationState>(
      listenWhen: (previous, current) => current is ChangeParticipationState,
      listener: (context, state) {
        if (state is ChangeParticipationState) {
          controller.resetEventsParticipatedInList();
        }
      },
      child: BlocBuilder<EventsParticipatedInCubit, EventsParticipatedInState>(
        buildWhen: (previous, current) =>
            current is EventsParticipatedInListChangeState,
        builder: (context, state) =>
            controller.eventsParticipatedInList.isNotEmpty
                ? const EventsParticipatedInCardList()
                : AnimationLoaderWidget(
                    text: AppText.eventsParticipatedInEmpty.tr(),
                    animation: AppImages.emptyEvents,
                  ),
      ),
    );
  }
}

import 'package:evently_app/features/events_participated_in/presentation/views/widgets/events_participated_in_card.dart';
import 'package:evently_app/features/events_participated_in/presentation/views_model/events_participated_in_cubit.dart';
import 'package:evently_app/features/events_participated_in/presentation/views_model/events_participated_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsParticipatedInCardList extends StatelessWidget {
  const EventsParticipatedInCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventsParticipatedInCubit>(context);
    return RPadding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<EventsParticipatedInCubit, EventsParticipatedInState>(
        buildWhen: (previous, current) =>
            current is EventsParticipatedInListChangeState,
        builder: (context, state) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => EventsParticipatedInCard(
            eventData: controller.eventsParticipatedInList[index],
          ),
          separatorBuilder: (_, __) => const RSizedBox(height: 16),
          itemCount: controller.eventsParticipatedInList.length,
        ),
      ),
    );
  }
}

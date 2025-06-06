import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/animation_loader_widget.dart';
import 'package:evently_app/features/created_events/presentation/views/widgets/created_event_card_list.dart';
import 'package:evently_app/features/created_events/presentation/views_model/created_events_cubit.dart';
import 'package:evently_app/features/created_events/presentation/views_model/created_events_state.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedEventsList extends StatelessWidget {
  const CreatedEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreatedEventsCubit>(context);
    return BlocListener<EventlyBottomNavigationCubit,
        EventlyBottomNavigationState>(
      listenWhen: (previous, current) => current is DeleteEventState,
      listener: (context, state) {
        if (state is DeleteEventState) {
          controller.resetCreatedEventsList();
        }
      },
      child: BlocBuilder<CreatedEventsCubit, CreatedEventsState>(
        buildWhen: (previous, current) =>
            current is CreatedEventsListChangeState,
        builder: (context, state) => controller.createdEventsList.isNotEmpty
            ? const CreatedEventCardList()
            : const AnimationLoaderWidget(
                text: AppText.createdEventsEmpty,
                animation: AppImages.emptyEvents,
              ),
      ),
    );
  }
}

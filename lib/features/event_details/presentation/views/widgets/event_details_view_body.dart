import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_creator_section.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_details_category_image.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_details_date_time_section.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_details_description_section.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_details_location_map.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_details_location_section.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/event_participate_section.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/join_the_event_button.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsViewBody extends StatelessWidget {
  const EventDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventDetailsCubit>(context);
    return BlocListener<EventDetailsCubit, EventDetailsState>(
      listener: (context, state) {
        if (state is FetchEventCreatorFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is FetchParticipateUsersFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is ToggleParticipateInOutEventFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        }
      },
      child: SingleChildScrollView(
        child: RPadding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventDetailsCategoryImage(
                eventCategory: controller.eventData.eventCategory,
              ),
              const RSizedBox(height: 16),
              RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  controller.eventData.eventTitle ?? "",
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const RSizedBox(height: 16),
              EventDetailsDateTimeSection(eventData: controller.eventData),
              const RSizedBox(height: 16),
              EventDetailsLocationSection(eventData: controller.eventData),
              const RSizedBox(height: 16),
              EventDetailsLocationMap(
                eventData: controller.eventData,
              ),
              const RSizedBox(height: 16),
              EventDetailsDescriptionSection(
                description: controller.eventData.eventDescription,
              ),
              const RSizedBox(height: 16),
              const EventCreatorSection(),
              const RSizedBox(height: 16),
              const EventParticipateSection(),
              const JoinTheEventButton(),
            ],
          ),
        ),
      ),
    );
  }
}

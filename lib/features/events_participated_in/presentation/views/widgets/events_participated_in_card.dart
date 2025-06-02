import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/event_details/presentation/views/event_details_view.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/events_participated_in/presentation/views/widgets/events_participated_in_card_date.dart';
import 'package:evently_app/features/events_participated_in/presentation/views/widgets/events_participated_in_card_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsParticipatedInCard extends StatelessWidget {
  const EventsParticipatedInCard({
    super.key,
    required this.eventData,
  });
  final EventModel eventData;
  @override
  Widget build(BuildContext context) {
    final eventlyController =
        BlocProvider.of<EventlyBottomNavigationCubit>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<EventlyBottomNavigationCubit>.value(
                value: eventlyController,
              ),
              BlocProvider<EventDetailsCubit>(
                create: (context) => EventDetailsCubit(
                  context,
                  eventData,
                  eventlyController.currentUserData ?? UserModel.empty(),
                ),
              )
            ],
            child: const EventDetailsView(),
          ),
        ),
      ),
      child: Container(
        width: ScreenUtil().screenWidth,
        height: 203.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurStyle: BlurStyle.outer,
              blurRadius: 6.r,
            )
          ],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  EventlyMethodsHelper.getEventCategoryImage(
                    eventCategory: eventData.eventCategory ?? "",
                    context: context,
                  ),
                  fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame == null) {
                      return const EventImageCardShimmer();
                    }
                    return child;
                  },
                ),
              ),
            ),
            RPadding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EventsParticipatedInCardDate(
                    eventDate: eventData.eventDate ?? DateTime.now(),
                  ),
                  EventsParticipatedInCardTitle(
                    eventTitle: eventData.eventTitle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

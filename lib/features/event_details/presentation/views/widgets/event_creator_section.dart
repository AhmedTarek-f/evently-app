import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/display_user_details.dart';
import 'package:evently_app/core/common_widgets/shimmer/display_user_details_shimmer.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCreatorSection extends StatelessWidget {
  const EventCreatorSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventDetailsCubit>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.eventCreator.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        BlocBuilder<EventDetailsCubit, EventDetailsState>(
          buildWhen: (previous, current) =>
              current is FetchEventCreatorLoadingState ||
              current is FetchEventCreatorSuccessState,
          builder: (context, state) => state is FetchEventCreatorLoadingState
              ? const DisplayUserDetailsShimmer(isCreator: true)
              : DisplayUserDetails(
                  userData: controller.eventCreatorData,
                  isCreator: true,
                ),
        ),
      ],
    );
  }
}

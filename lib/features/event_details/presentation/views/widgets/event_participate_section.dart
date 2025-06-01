import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/participating_members_list.dart';
import 'package:evently_app/features/event_details/presentation/views/widgets/participating_members_list_shimmer.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventParticipateSection extends StatelessWidget {
  const EventParticipateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.participatingMembers.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const RSizedBox(height: 12),
        BlocBuilder<EventDetailsCubit, EventDetailsState>(
          buildWhen: (previous, current) =>
              current is FetchParticipateUsersSuccessState ||
              current is FetchParticipateUsersLoadingState,
          builder: (context, state) =>
              state is FetchParticipateUsersLoadingState
                  ? const ParticipatingMembersListShimmer()
                  : const ParticipatingMembersList(),
        ),
      ],
    );
  }
}

import 'package:evently_app/core/common_widgets/display_user_details.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipatingMembersList extends StatelessWidget {
  const ParticipatingMembersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventDetailsCubit>(context);
    return RSizedBox(
      height: 74,
      child: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        buildWhen: (previous, current) =>
            current is ChangeParticipateUsersState,
        builder: (context, state) => controller.participatingMembersData.isEmpty
            ? Center(
                child: Text(
                  AppText.participatingMembersEmpty,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => DisplayUserDetails(
                  userData: controller.participatingMembersData[index],
                ),
                separatorBuilder: (_, __) => const RSizedBox(width: 8),
                itemCount: controller.participatingMembersData.length,
              ),
      ),
    );
  }
}

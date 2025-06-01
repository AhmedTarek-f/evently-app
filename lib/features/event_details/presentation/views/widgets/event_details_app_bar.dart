import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const EventDetailsAppBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final controller = BlocProvider.of<EventDetailsCubit>(context);
    return AppBar(
      scrolledUnderElevation: 0,
      foregroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: true,
      title: const Text(AppText.eventDetails),
      centerTitle: true,
      actions: controller.eventData.eventCreatorId == userId
          ? [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppIcons.edit,
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppIcons.delete,
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.cover,
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

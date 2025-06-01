import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/dialogs/dialogs.dart';
import 'package:evently_app/core/common_widgets/loading_button.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/edit_event/presentation/views/edit_event_view.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<EditEventCubit>(
                        create: (context) => EditEventCubit(controller),
                        child: const EditEventView(),
                      ),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  AppIcons.edit,
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                onPressed: () {
                  Dialogs.showOptionDialog(
                    context: context,
                    firstButtonTitle: '',
                    secondButtonTitle: '',
                    optionDialogContent:
                        "${AppText.deleteEventMessage} ${controller.eventData.eventTitle}",
                    contentHorizontalPadding: 16,
                    dialogButton: BlocProvider.value(
                      value: controller,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              buttonTitle: AppText.cancel,
                            ),
                          ),
                          const RSizedBox(width: 16),
                          BlocBuilder<EventDetailsCubit, EventDetailsState>(
                            buildWhen: (previous, current) =>
                                current is DeleteEventLoadingState,
                            builder: (context, state) =>
                                state is DeleteEventLoadingState
                                    ? const Expanded(
                                        child: LoadingButton(
                                          backgroundColor: AppColors.red,
                                        ),
                                      )
                                    : Expanded(
                                        child: CustomElevatedButton(
                                          onPressed: () async =>
                                              await controller.deleteEvent(),
                                          buttonTitle: AppText.delete,
                                          backgroundColor: AppColors.red,
                                        ),
                                      ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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

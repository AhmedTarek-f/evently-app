import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/loading_button.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinTheEventButton extends StatelessWidget {
  const JoinTheEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventDetailsCubit>(context);
    return Visibility(
      visible: controller.eventData.eventCreatorId !=
          FirebaseAuth.instance.currentUser?.uid,
      child: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        buildWhen: (previous, current) =>
            current is GetUserJoiningState ||
            current is ToggleParticipateInOutEventSuccessState ||
            current is ToggleParticipateInOutEventLoadingState ||
            current is ToggleParticipateInOutEventFailureState,
        builder: (context, state) => Column(
          children: [
            const RSizedBox(height: 32),
            state is ToggleParticipateInOutEventLoadingState &&
                    controller.isJoinedIn
                ? const LoadingButton(
                    backgroundColor: AppColors.red,
                  )
                : state is ToggleParticipateInOutEventLoadingState &&
                        !controller.isJoinedIn
                    ? const LoadingButton()
                    : CustomElevatedButton(
                        onPressed: () async {
                          await controller.toggleJoinTheEvent();
                        },
                        buttonTitle: controller.isJoinedIn
                            ? AppText.cancelParticipation
                            : AppText.joinTheEvent,
                        backgroundColor: controller.isJoinedIn
                            ? AppColors.red
                            : Theme.of(context).colorScheme.primary,
                      ),
          ],
        ),
      ),
    );
  }
}

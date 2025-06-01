import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/loading_button.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateEventButton extends StatelessWidget {
  const UpdateEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditEventCubit>(context);
    return BlocBuilder<EditEventCubit, EditEventState>(
      buildWhen: (previous, current) =>
          current is EditEventFailureState || current is EditEventLoadingState,
      builder: (context, state) => controller.isLoading
          ? const LoadingButton()
          : CustomElevatedButton(
              onPressed: () async {
                await controller.updateEvent();
              },
              buttonTitle: AppText.updateEvent,
            ),
    );
  }
}

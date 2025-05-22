import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/loading_circle.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreateEventCubit>(context);
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) =>
          current is CreateEventFailureState ||
          current is CreateEventLoadingState,
      builder: (context, state) => controller.isLoading
          ? CustomElevatedButton(
              onPressed: () {},
              buttonTitle: "",
              isText: false,
              child: const LoadingCircle(),
            )
          : CustomElevatedButton(
              onPressed: () async {
                await controller.addEvent();
              },
              buttonTitle: AppText.addEvent,
            ),
    );
  }
}

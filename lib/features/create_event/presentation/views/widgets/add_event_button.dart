import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/loading_button.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreateEventCubit>(context);
    final startController = BlocProvider.of<StartCubit>(context);
    final String currentLocale = startController.isArLanguage ? "ar" : "en";
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) =>
          current is CreateEventFailureState ||
          current is CreateEventLoadingState,
      builder: (context, state) => controller.isLoading
          ? const LoadingButton()
          : CustomElevatedButton(
              onPressed: () async {
                await controller.addEvent(locale: currentLocale);
              },
              buttonTitle: AppText.addEvent,
            ),
    );
  }
}

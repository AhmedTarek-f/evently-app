import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_categories_list.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_date_and_time_section.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_form.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_image_card.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_location_section.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/update_event_button.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditEventViewBody extends StatelessWidget {
  const EditEventViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditEventCubit>(context);
    return BlocConsumer<EditEventCubit, EditEventState>(
      listenWhen: (previous, current) =>
          current is PickingDateValidationState ||
          current is PickingTimeValidationState ||
          current is EditEventFailureState ||
          current is EditEventSuccessState ||
          current is EventLocationValidationState ||
          current is SelectEventLocationFailureState ||
          current is NoChangeState,
      listener: (context, state) {
        if (state is PickingDateValidationState) {
          Loaders.showErrorMessage(
            message: AppText.eventDateValidation,
            context: context,
          );
        } else if (state is PickingTimeValidationState) {
          Loaders.showErrorMessage(
            message: AppText.eventTimeValidation,
            context: context,
          );
        } else if (state is SelectEventLocationFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is EventLocationValidationState) {
          Loaders.showErrorMessage(
            message: AppText.eventLocationValidation,
            context: context,
          );
        } else if (state is EditEventFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is EditEventSuccessState) {
          controller.animateCameraToNewEventLocation();
          controller.eventDetailsController.applyEdit();
          Navigator.of(context).pop();
          Loaders.showSuccessMessage(
            message: AppText.editingEventSuccessMessage,
            context: context,
          );
        } else if (state is NoChangeState) {
          Navigator.of(context).pop();
        }
      },
      buildWhen: (previous, current) =>
          current is EditEventLoadingState || current is EditEventFailureState,
      builder: (context, state) => AbsorbPointer(
        absorbing: controller.isLoading,
        child: const SingleChildScrollView(
          child: RPadding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditEventImageCard(),
                RSizedBox(height: 16),
                EditEventCategoriesList(),
                RSizedBox(height: 16),
                EditEventForm(),
                RSizedBox(height: 16),
                EditEventDateAndTimeSection(),
                RSizedBox(height: 16),
                EditEventLocationSection(),
                RSizedBox(height: 16),
                UpdateEventButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

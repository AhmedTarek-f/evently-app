import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/add_event_button.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/create_event_form.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/date_and_time_section.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/event_categories_list.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/event_image_card.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/location_section.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEventViewBody extends StatelessWidget {
  const CreateEventViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreateEventCubit>(context);
    return BlocConsumer<CreateEventCubit, CreateEventState>(
      listenWhen: (previous, current) =>
          current is PickingDateValidationState ||
          current is PickingTimeValidationState ||
          current is CreateEventFailureState ||
          current is CreateEventSuccessState ||
          current is EventLocationValidationState ||
          current is SelectEventLocationFailureState,
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
        } else if (state is CreateEventFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is CreateEventSuccessState) {
          Navigator.of(context).pop();
          Loaders.showSuccessMessage(
            message: AppText.addingEventSuccessMessage,
            context: context,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is CreateEventLoadingState ||
          current is CreateEventFailureState,
      builder: (context, state) => AbsorbPointer(
        absorbing: controller.isLoading,
        child: const SingleChildScrollView(
          child: RPadding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventImageCard(),
                RSizedBox(height: 16),
                EventCategoriesList(),
                RSizedBox(height: 16),
                CreateEventForm(),
                RSizedBox(height: 16),
                DateAndTimeSection(),
                RSizedBox(height: 16),
                LocationSection(),
                RSizedBox(height: 16),
                AddEventButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

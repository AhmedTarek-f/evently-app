import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_text_form_field.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/validations.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_title_form_field.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditEventForm extends StatelessWidget {
  const EditEventForm({super.key});

  @override
  Widget build(BuildContext context) {
    final editEventController = BlocProvider.of<EditEventCubit>(context);
    return BlocBuilder<EditEventCubit, EditEventState>(
      buildWhen: (previous, current) => current is EnableAutoValidateModeState,
      builder: (context, state) => Form(
        key: editEventController.editEventFormKey,
        autovalidateMode: editEventController.autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.title.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const RSizedBox(height: 8),
            const EditEventTitleFormField(),
            const RSizedBox(height: 16),
            Text(
              AppText.description.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const RSizedBox(height: 8),
            CustomTextFormField(
              controller: editEventController.eventDescriptionController,
              labelText: null,
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              hintText: AppText.descriptionHint,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              maxLines: 4,
              validator: (value) =>
                  Validations.eventDescriptionValidation(value),
            ),
          ],
        ),
      ),
    );
  }
}

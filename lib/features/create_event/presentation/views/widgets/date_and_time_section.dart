import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/date_and_time_row.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateAndTimeSection extends StatelessWidget {
  const DateAndTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreateEventCubit>(context);
    final startController = BlocProvider.of<StartCubit>(context);
    final String currentLocale = startController.isArLanguage ? "ar" : "en";
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) =>
          current is PickingDateState || current is PickingTimeState,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateAndTimeRow(
            title: AppText.eventDate,
            icon: AppIcons.calendar,
            buttonTitle: controller.pickedDate != null
                ? controller.pickedDate!
                : AppText.chooseDate,
            onTap: () async {
              final DateTime? date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: controller.pickedDate != null
                    ? controller.parseDate(
                        dateString: controller.pickedDate!,
                        locale: currentLocale,
                      )
                    : null,
              );
              if (date != null) {
                controller.formatDate(
                  date: date,
                  locale: currentLocale,
                );
              }
            },
          ),
          const RSizedBox(height: 16),
          DateAndTimeRow(
            title: AppText.eventTime,
            icon: AppIcons.clock,
            buttonTitle: controller.pickedTime != null
                ? controller.pickedTime!
                : AppText.chooseTime,
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: controller.pickedTime != null
                    ? controller.parseTimeOfDay(
                        timeString: controller.pickedTime!,
                        locale: currentLocale,
                      )
                    : TimeOfDay.now(),
              );
              if (time != null) {
                controller.formatTime(
                  time: time,
                  locale: currentLocale,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

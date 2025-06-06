import 'package:evently_app/features/events_participated_in/presentation/views_model/events_participated_in_cubit.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsParticipatedInCardDate extends StatelessWidget {
  const EventsParticipatedInCardDate({
    super.key,
    required this.eventDate,
  });
  final DateTime eventDate;
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventsParticipatedInCubit>(context);
    final startController = BlocProvider.of<StartCubit>(context);
    final currentLocale = startController.isArLanguage ? "ar" : "en";
    final List<String> date = controller.getEventDate(
      date: eventDate,
      locale: currentLocale,
    );
    return Container(
      padding: REdgeInsets.symmetric(vertical: 4),
      width: 43.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryFixed,
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.first,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            date.last,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:evently_app/features/created_events/presentation/views/widgets/created_event_card.dart';
import 'package:evently_app/features/created_events/presentation/views_model/created_events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatedEventCardList extends StatelessWidget {
  const CreatedEventCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreatedEventsCubit>(context);
    return RPadding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => CreatedEventCard(
          eventData: controller.createdEventsList[index],
        ),
        separatorBuilder: (_, __) => const RSizedBox(height: 16),
        itemCount: controller.createdEventsList.length,
      ),
    );
  }
}

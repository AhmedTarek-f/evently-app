import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/map/presentation/views/widgets/event_horizontal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsHorizontalList extends StatelessWidget {
  const EventsHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 94,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => EventHorizontalItem(
          eventData: EventlyMethodsHelper.allEvents[index],
        ),
        separatorBuilder: (_, __) => const RSizedBox(
          width: 10,
        ),
        itemCount: EventlyMethodsHelper.allEvents.length,
      ),
    );
  }
}

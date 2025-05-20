import 'package:evently_app/core/common_widgets/event_card/event_card.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteEventCardList extends StatelessWidget {
  const FavoriteEventCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) => EventCard(
        eventData: EventModel(
            eventDate: "21 Nov",
            eventTitle: "Meeting for Updating The Development Method",
            eventCategory: "meeting"),
      ),
      separatorBuilder: (_, __) => const RSizedBox(
        height: 16,
      ),
      itemCount: 20,
    );
  }
}

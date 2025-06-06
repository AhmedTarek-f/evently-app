import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCardsShimmerList extends StatelessWidget {
  const EventCardsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => const RPadding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: EventImageCardShimmer(),
      ),
      separatorBuilder: (_, __) => const RSizedBox(height: 16),
      itemCount: 15,
    );
  }
}

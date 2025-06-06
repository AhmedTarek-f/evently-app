import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsCategoryImage extends StatelessWidget {
  const EventDetailsCategoryImage({
    super.key,
    required this.eventCategory,
  });

  final String? eventCategory;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Image.asset(
        EventlyMethodsHelper.getEventCategoryImage(
          eventCategory: eventCategory ?? "",
          context: context,
        ),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame == null) {
            return const EventImageCardShimmer();
          }
          return child;
        },
      ),
    );
  }
}

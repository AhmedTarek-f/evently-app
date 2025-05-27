import 'package:evently_app/core/common_widgets/event_card/event_card_date.dart';
import 'package:evently_app/core/common_widgets/event_card/event_card_title_and_favorite_row.dart';
import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.eventData,
    this.isFavorite = false,
    this.onFavoritePressed,
  });
  final EventModel eventData;
  final bool isFavorite;
  final void Function()? onFavoritePressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 203.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurStyle: BlurStyle.outer,
            blurRadius: 6.r,
          )
        ],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                EventlyMethodsHelper.getEventCategoryImage(
                  eventCategory: eventData.eventCategory ?? "",
                  context: context,
                ),
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (frame == null) {
                    return const EventImageCardShimmer();
                  }
                  return child;
                },
              ),
            ),
          ),
          RPadding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventCardDate(
                  eventDate: eventData.eventDate ?? DateTime.now(),
                ),
                EventCardTitleAndFavoriteRow(
                  eventData: eventData,
                  isFavorite: isFavorite,
                  onFavoritePressed: onFavoritePressed,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

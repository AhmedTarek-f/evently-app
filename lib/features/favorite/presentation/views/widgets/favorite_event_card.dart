import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_card_date.dart';
import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_card_title_and_favorite_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteEventCard extends StatelessWidget {
  const FavoriteEventCard({
    super.key,
    required this.eventData,
    this.isFavorite = false,
  });
  final EventModel eventData;
  final bool isFavorite;
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
                FavoriteEventCardDate(
                  eventDate: eventData.eventDate ?? DateTime.now(),
                ),
                FavoriteEventCardTitleAndFavoriteRow(
                  eventData: eventData,
                  isFavorite: isFavorite,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

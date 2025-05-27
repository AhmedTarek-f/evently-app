import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventCardTitleAndFavoriteRow extends StatelessWidget {
  const EventCardTitleAndFavoriteRow({
    super.key,
    required this.eventData,
    required this.isFavorite,
    this.onFavoritePressed,
  });

  final EventModel eventData;
  final bool isFavorite;
  final void Function()? onFavoritePressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryFixed,
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              eventData.eventTitle ?? "",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          ),
          const RSizedBox(width: 4),
          IconButton(
            onPressed: onFavoritePressed,
            icon: SvgPicture.asset(
              isFavorite ? AppIcons.favoriteFilled : AppIcons.favorite,
            ),
          ),
        ],
      ),
    );
  }
}

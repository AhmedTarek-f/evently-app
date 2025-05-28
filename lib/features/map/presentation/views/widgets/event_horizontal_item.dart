import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventHorizontalItem extends StatelessWidget {
  const EventHorizontalItem({super.key, required this.eventData});
  final EventModel eventData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryFixed,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurStyle: BlurStyle.outer,
            blurRadius: 4.r,
          )
        ],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: RPadding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                EventlyMethodsHelper.getEventCategoryImage(
                  eventCategory: eventData.eventCategory ?? "",
                  context: context,
                ),
                width: 138.w,
                height: 78.h,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (frame == null) {
                    return EventImageCardShimmer(
                      width: 138.w,
                      height: 78.h,
                    );
                  }
                  return child;
                },
              ),
            ),
            const RSizedBox(width: 10),
            RSizedBox(
              width: 157,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    eventData.eventTitle ?? "",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const RSizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.inactiveMapLight,
                        width: 24.r,
                        height: 24.r,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const RSizedBox(width: 4),
                      Text(
                        "Cairo , Egypt",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailsLocationSection extends StatelessWidget {
  const EventDetailsLocationSection({super.key, required this.eventData});
  final EventModel eventData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryFixed,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(
          16.r,
        ),
      ),
      child: RPadding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 46.r,
              height: 46.r,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
              child: SvgPicture.asset(
                AppIcons.location,
                width: 22.r,
                height: 22.r,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primaryFixed,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const RSizedBox(width: 8),
            Expanded(
              child: Text(
                "${eventData.eventCountry} , ${eventData.eventCity}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

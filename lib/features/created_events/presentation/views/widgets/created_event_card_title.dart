import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatedEventCardTitle extends StatelessWidget {
  const CreatedEventCardTitle({
    super.key,
    required this.eventTitle,
  });

  final String? eventTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              eventTitle ?? "",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

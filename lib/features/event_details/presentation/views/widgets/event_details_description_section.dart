import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsDescriptionSection extends StatelessWidget {
  const EventDetailsDescriptionSection({super.key, required this.description});
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.description.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const RSizedBox(height: 8),
        Text(
          description ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

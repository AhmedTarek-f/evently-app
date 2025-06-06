import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DateAndTimeRow extends StatelessWidget {
  const DateAndTimeRow({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    required this.buttonTitle,
  });
  final void Function()? onTap;
  final String title;
  final String icon;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.secondary,
            BlendMode.srcIn,
          ),
        ),
        const RSizedBox(width: 10),
        Expanded(
          child: Text(
            title.tr(),
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        InkWell(
          onTap: onTap,
          highlightColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          splashColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(100.r),
          child: RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              buttonTitle.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

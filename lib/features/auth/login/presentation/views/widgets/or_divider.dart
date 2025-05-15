import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Row(
        children: [
          Expanded(
              child: Divider(color: Theme.of(context).colorScheme.primary)),
          RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppText.or.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Expanded(
              child: Divider(
            color: Theme.of(context).colorScheme.primary,
          )),
        ],
      ),
    );
  }
}

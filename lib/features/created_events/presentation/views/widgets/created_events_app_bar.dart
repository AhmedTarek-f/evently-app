import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class CreatedEventsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreatedEventsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppText.createdEvents.tr(),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      foregroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

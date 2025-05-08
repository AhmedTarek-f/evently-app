import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class ForgetPasswordAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ForgetPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppText.forgetPasswordTitle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

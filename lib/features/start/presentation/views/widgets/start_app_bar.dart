import 'package:evently_app/core/common_widgets/evently_logo_row.dart';
import 'package:flutter/material.dart';

class StartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const EventlyLogoRow(),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';

class EmptyEventsLoader extends StatelessWidget {
  const EmptyEventsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        AnimationLoaderWidget(
          text: AppText.emptyEvents,
          animation: AppImages.emptyEvents,
        )
      ],
    );
  }
}

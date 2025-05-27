import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/animation_loader_widget.dart';
import 'package:evently_app/features/home/presentation/views_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyEventsLoader extends StatelessWidget {
  const EmptyEventsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = BlocProvider.of<HomeCubit>(context);
    return RefreshIndicator(
      onRefresh: () async => await homeController.reloadEventTapsList(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          AnimationLoaderWidget(
            text: AppText.emptyEvents,
            animation: AppImages.emptyEvents,
          )
        ],
      ),
    );
  }
}

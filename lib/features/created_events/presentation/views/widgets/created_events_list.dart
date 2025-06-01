import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/animation_loader_widget.dart';
import 'package:evently_app/features/created_events/presentation/views/widgets/created_event_card_list.dart';
import 'package:evently_app/features/created_events/presentation/views_model/created_events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedEventsList extends StatelessWidget {
  const CreatedEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreatedEventsCubit>(context);
    return controller.createdEventsList.isNotEmpty
        ? const CreatedEventCardList()
        : AnimationLoaderWidget(
            text: AppText.createdEventsEmpty.tr(),
            animation: AppImages.emptyEvents,
          );
  }
}

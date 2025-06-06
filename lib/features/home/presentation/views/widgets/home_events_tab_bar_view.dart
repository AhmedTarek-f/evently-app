import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/animation_loader_widget.dart';
import 'package:evently_app/features/home/presentation/views/widgets/home_event_card_list.dart';
import 'package:evently_app/features/home/presentation/views_model/home_cubit.dart';
import 'package:evently_app/features/home/presentation/views_model/home_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeEventsTabBarView extends StatelessWidget {
  const HomeEventsTabBarView({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    final homeController = BlocProvider.of<HomeCubit>(context);
    final startController = BlocProvider.of<StartCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is ChangeSelectedCategoryState,
      builder: (context, state) => TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: homeController.eventTapsList
            .map(
              (eventsList) => eventsList.isEmpty
                  ? AnimationLoaderWidget(
                      text: startController.isArLanguage
                          ? "${AppText.noAvailable.tr()} ${AppText.events.tr()} ${homeController.selectedCategoryItem.categoryName.tr()} ${AppText.yet.tr()}"
                          : "${AppText.noAvailable.tr()} ${homeController.selectedCategoryItem.categoryName.tr()} ${AppText.events.tr()} ${AppText.yet.tr()}",
                      animation: AppImages.emptyEvents,
                    )
                  : HomeEventCardList(
                      eventsList: eventsList,
                    ),
            )
            .toList(),
      ),
    );
  }
}

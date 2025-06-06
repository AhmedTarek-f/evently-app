import 'package:evently_app/features/home/presentation/views/widgets/home_event_category_item.dart';
import 'package:evently_app/features/home/presentation/views_model/home_cubit.dart';
import 'package:evently_app/features/home/presentation/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeEventCategoriesTapBar extends StatelessWidget {
  const HomeEventCategoriesTapBar({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    final homeController = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is ChangeSelectedCategoryState,
      builder: (context, state) => RPadding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: TabBar(
          onTap: (value) {
            homeController.getCurrentCategorySelectedTap(
              tapIndex: value,
            );
          },
          controller: tabController,
          splashFactory: NoSplash.splashFactory,
          physics: const BouncingScrollPhysics(),
          indicator: const BoxDecoration(),
          dividerHeight: 0,
          isScrollable: true,
          indicatorWeight: 0,
          tabAlignment: TabAlignment.start,
          labelPadding: REdgeInsets.symmetric(horizontal: 8),
          tabs: homeController.eventCategoriesList.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final category = entry.value;
              return Tab(
                child: HomeEventCategoryItem(
                  categoryDetails: category,
                  isSelected: homeController.currentCategoryIndex == index,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

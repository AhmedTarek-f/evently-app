import 'package:evently_app/core/common_widgets/shimmer/event_cards_shimmer_list.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/home/presentation/views/widgets/empty_events_loader.dart';
import 'package:evently_app/features/home/presentation/views/widgets/home_details_app_bar.dart';
import 'package:evently_app/features/home/presentation/views/widgets/home_events_tab_bar_view.dart';
import 'package:evently_app/features/home/presentation/views_model/home_cubit.dart';
import 'package:evently_app/features/home/presentation/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final HomeCubit homeController;

  @override
  void initState() {
    super.initState();
    homeController = BlocProvider.of<HomeCubit>(context);
    _tabController = TabController(
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 300),
      length: homeController.eventCategoriesList.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      homeController.getCurrentCategorySelectedTap(
          tapIndex: _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is FetchCachedEventsState,
      builder: (context, state) => DefaultTabController(
        length: homeController.eventCategoriesList.length,
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            HomeDetailsAppBar(
              tabController: _tabController,
            ),
          ],
          body: BlocConsumer<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                current is FetchEventsFailureState ||
                current is ToggleFavoriteFailureState,
            listener: (context, state) {
              if (state is FetchEventsFailureState) {
                Loaders.showErrorMessage(
                  message: state.errorMessage,
                  context: context,
                );
              } else if (state is ToggleFavoriteFailureState) {
                Loaders.showErrorMessage(
                  message: state.errorMessage,
                  context: context,
                );
              }
            },
            buildWhen: (previous, current) =>
                current is FetchEventsLoadingState ||
                current is FetchEventsSuccessState ||
                current is FetchCachedEventsState,
            builder: (context, state) => state is FetchEventsLoadingState
                ? const EventCardsShimmerList()
                : EventlyMethodsHelper.allEvents.isEmpty
                    ? const EmptyEventsLoader()
                    : HomeEventsTabBarView(
                        tabController: _tabController,
                      ),
          ),
        ),
      ),
    );
  }
}

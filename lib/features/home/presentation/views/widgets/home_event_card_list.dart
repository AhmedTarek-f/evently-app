import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/home/presentation/views/widgets/home_event_card.dart';
import 'package:evently_app/features/home/presentation/views_model/home_cubit.dart';
import 'package:evently_app/features/home/presentation/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeEventCardList extends StatelessWidget {
  const HomeEventCardList({
    super.key,
    required this.eventsList,
  });
  final List<EventModel> eventsList;
  @override
  Widget build(BuildContext context) {
    final eventlyController =
        BlocProvider.of<EventlyBottomNavigationCubit>(context);
    final homeController = BlocProvider.of<HomeCubit>(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is ToggleFavoriteSuccessState,
        builder: (context, state) => RefreshIndicator(
          onRefresh: () async => await homeController.reloadEventTapsList(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          child: ListView.separated(
            padding: REdgeInsets.only(top: 16),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) => HomeEventCard(
              eventData: eventsList[index],
              isFavorite: eventlyController.currentUserData?.favoriteEvents
                      .contains(eventsList[index].eventId) ??
                  false,
            ),
            separatorBuilder: (_, __) => const RSizedBox(height: 16),
            itemCount: eventsList.length,
          ),
        ),
      ),
    );
  }
}

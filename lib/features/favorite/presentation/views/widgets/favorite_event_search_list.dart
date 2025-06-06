import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_card.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_cubit.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteEventSearchList extends StatelessWidget {
  const FavoriteEventSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<FavoriteCubit>(context);
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listenWhen: (previous, current) =>
          current is DeleteFavoriteEventFailureState,
      listener: (context, state) {
        if (state is DeleteFavoriteEventFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is DeleteFavoriteEventLoadingState ||
          current is DeleteFavoriteEventSuccessState ||
          current is ChangeSearchFieldValueState,
      builder: (context, state) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => FavoriteEventCard(
          eventData: controller.searchFavoriteEventsList[index],
          isFavorite: true,
        ),
        separatorBuilder: (_, __) => const RSizedBox(height: 16),
        itemCount: controller.searchFavoriteEventsList.length,
      ),
    );
  }
}

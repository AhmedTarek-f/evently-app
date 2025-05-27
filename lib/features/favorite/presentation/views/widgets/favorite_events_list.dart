import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/animation_loader_widget.dart';
import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_card_list.dart';
import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_search_list.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_cubit.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteEventsList extends StatelessWidget {
  const FavoriteEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = BlocProvider.of<FavoriteCubit>(context);
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (previous, current) =>
          current is ChangeSearchFieldValueState ||
          current is DeleteFavoriteEventSuccessState,
      builder: (context, state) =>
          favoriteController.searchFavoriteEventsList.isNotEmpty
              ? const Expanded(child: FavoriteEventSearchList())
              : favoriteController.favoriteEvents.isNotEmpty
                  ? const Expanded(child: FavoriteEventCardList())
                  : Expanded(
                      child: AnimationLoaderWidget(
                        text: AppText.favoriteEventsEmpty.tr(),
                        animation: AppImages.emptyEvents,
                      ),
                    ),
    );
  }
}

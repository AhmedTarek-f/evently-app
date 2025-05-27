import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_cubit.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteEventSearchField extends StatelessWidget {
  const FavoriteEventSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<FavoriteCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          style: Theme.of(context).textTheme.bodyMedium,
          controller: controller.favoriteSearchField,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(
              maxWidth: 56.r,
              maxHeight: 56.r,
            ),
            contentPadding: REdgeInsets.all(16),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primaryFixed,
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
            hintText: AppText.searchForEvent.tr(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
            ),
            prefixIcon: RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(
                AppIcons.search,
                width: 56.r,
                height: 56.r,
              ),
            ),
          ),
          onChanged: (value) =>
              controller.favoriteEventsSearch(eventTitle: value),
        ),
        BlocBuilder<FavoriteCubit, FavoriteState>(
          buildWhen: (previous, current) =>
              current is ChangeSearchFieldValueState ||
              current is DeleteFavoriteEventSuccessState,
          builder: (context, state) => Visibility(
            visible: controller.searchFavoriteEventsList.isEmpty &&
                controller.favoriteSearchField.text.isNotEmpty,
            child: RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RSizedBox(height: 4),
                  Text(
                    AppText.inValidEventSearch,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

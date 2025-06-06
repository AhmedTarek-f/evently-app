import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/home/presentation/views_model/home_cubit.dart';
import 'package:evently_app/features/home/presentation/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class HomeEventCardTitleAndFavoriteRow extends StatelessWidget {
  const HomeEventCardTitleAndFavoriteRow({
    super.key,
    required this.eventData,
    required this.isFavorite,
  });

  final EventModel eventData;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    final eventlyController =
        BlocProvider.of<EventlyBottomNavigationCubit>(context);
    final homeController = BlocProvider.of<HomeCubit>(context);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryFixed,
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              eventData.eventTitle ?? "",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          ),
          const RSizedBox(width: 4),
          IconButton(
            onPressed: () async {
              await homeController.toggleFavorite(
                  userData:
                      eventlyController.currentUserData ?? UserModel.empty(),
                  eventId: eventData.eventId ?? "");
            },
            icon: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is ToggleFavoriteLoadingState ||
                  current is ToggleFavoriteSuccessState ||
                  current is ToggleFavoriteFailureState,
              builder: (context, state) => state
                          is ToggleFavoriteLoadingState &&
                      eventData.eventId == state.eventId
                  ? Lottie.asset(
                      AppImages.heartAnimation,
                      width: 24.r,
                      height: 24.r,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      isFavorite ? AppIcons.favoriteFilled : AppIcons.favorite,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:evently_app/features/home/presentation/views/widgets/home_event_categories_tap_bar.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDetailsAppBar extends StatelessWidget {
  const HomeDetailsAppBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<StartCubit>(context);
    final eventlyController =
        BlocProvider.of<EventlyBottomNavigationCubit>(context);
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      expandedHeight: 172.h,
      pinned: true,
      toolbarHeight: 172.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            24.r,
          ),
          bottomLeft: Radius.circular(
            24.r,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RSizedBox(height: 8),
              RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  AppText.welcomeBack.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                ),
                              ),
                              BlocConsumer<EventlyBottomNavigationCubit,
                                  EventlyBottomNavigationState>(
                                listenWhen: (previous, current) =>
                                    current is FetchUserDataFailureState,
                                listener: (context, state) {
                                  if (state is FetchUserDataFailureState) {
                                    Loaders.showErrorMessage(
                                      message: state.errorMessage,
                                      context: context,
                                    );
                                  }
                                },
                                buildWhen: (previous, current) =>
                                    current is FetchUserDataLoadingState ||
                                    current is FetchUserDataSuccessState,
                                builder: (context, state) => state
                                        is FetchUserDataLoadingState
                                    ? RPadding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: ShimmerEffect(
                                          width: ScreenUtil().screenWidth * 0.5,
                                          height: 16.h,
                                        ),
                                      )
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          eventlyController
                                                  .currentUserData?.userName ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          startController.isDarkMode
                              ? AppIcons.moon2
                              : AppIcons.sun2,
                          width: 24.r,
                          height: 24.r,
                          fit: BoxFit.cover,
                        ),
                        const RSizedBox(width: 10),
                        Container(
                          padding: REdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                          ),
                          child: Text(
                            startController.isArLanguage
                                ? AppText.ar.tr()
                                : AppText.en.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        )
                      ],
                    ),
                    const RSizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          startController.isDarkMode
                              ? AppIcons.inactiveMapDark
                              : AppIcons.inactiveMapLight,
                          width: 24.r,
                          height: 24.r,
                          fit: BoxFit.cover,
                        ),
                        const RSizedBox(width: 4),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              AppText.placeRightNow,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.w500,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        const RSizedBox(width: 72),
                      ],
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 16),
              HomeEventCategoriesTapBar(
                tabController: tabController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

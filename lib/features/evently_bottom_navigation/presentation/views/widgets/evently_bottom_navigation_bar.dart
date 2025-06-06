import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventlyBottomNavigationBar extends StatelessWidget {
  const EventlyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    final controller = BlocProvider.of<EventlyBottomNavigationCubit>(context);
    return BlocBuilder<EventlyBottomNavigationCubit,
        EventlyBottomNavigationState>(
      buildWhen: (previous, current) => current is ChangeTapState,
      builder: (context, state) => Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: (value) => controller.changeIndex(index: value),
          currentIndex: controller.currentTapIndex,
          items: [
            BottomNavigationBarItem(
              icon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.inactiveHomeDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.inactiveHomeLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              activeIcon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.activeHomeDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.activeHomeLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              label: AppText.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.inactiveMapDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.inactiveMapLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              activeIcon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.activeMapDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.activeMapLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              label: AppText.map.tr(),
            ),
            BottomNavigationBarItem(
              icon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.inactiveFavoritesDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.inactiveFavoritesLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              activeIcon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.activeFavoritesDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.activeFavoritesLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              label: AppText.favorite.tr(),
            ),
            BottomNavigationBarItem(
              icon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.inactiveProfileDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.inactiveProfileLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              activeIcon: isDarkTheme
                  ? SvgPicture.asset(
                      AppIcons.activeProfileDark,
                      width: 24.r,
                      height: 24.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.activeProfileLight,
                      width: 24.r,
                      height: 24.r,
                    ),
              label: AppText.profile.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

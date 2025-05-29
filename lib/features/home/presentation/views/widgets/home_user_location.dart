import 'package:evently_app/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeUserLocation extends StatelessWidget {
  const HomeUserLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<StartCubit>(context);
    final eventlyController =
        BlocProvider.of<EventlyBottomNavigationCubit>(context);
    return Row(
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
        BlocBuilder<EventlyBottomNavigationCubit, EventlyBottomNavigationState>(
          buildWhen: (previous, current) =>
              current is FetchUserDataLoadingState ||
              current is FetchUserDataSuccessState,
          builder: (context, state) => state is FetchUserDataLoadingState
              ? ShimmerEffect(
                  width: ScreenUtil().screenWidth * 0.5,
                  height: 16.h,
                )
              : Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      eventlyController.userCountry != null
                          ? "${eventlyController.userCountry} , ${eventlyController.userCity}"
                          : AppText.unknownLocation,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
        ),
        const RSizedBox(width: 72),
      ],
    );
  }
}

import 'package:evently_app/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class DisplayUserDetailsShimmer extends StatelessWidget {
  const DisplayUserDetailsShimmer({super.key, this.isCreator = false});
  final bool isCreator;
  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<StartCubit>(context);
    return Padding(
      padding: REdgeInsetsDirectional.only(start: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: isCreator,
            child: Lottie.asset(
              startController.isDarkMode
                  ? AppImages.darkCrownAnimation
                  : AppImages.lightCrownAnimation,
              width: 52.r,
              height: 52.r,
              fit: BoxFit.contain,
            ),
          ),
          ShimmerEffect(
            width: 50.r,
            height: 50.r,
            radius: 50.r,
          ),
          const RSizedBox(height: 4),
          ShimmerEffect(
            width: 70.w,
            height: 12.r,
          ),
        ],
      ),
    );
  }
}

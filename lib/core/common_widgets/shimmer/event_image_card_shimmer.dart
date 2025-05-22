import 'package:evently_app/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventImageCardShimmer extends StatelessWidget {
  const EventImageCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      width: ScreenUtil().screenWidth,
      height: 203.h,
      radius: 16.r,
    );
  }
}

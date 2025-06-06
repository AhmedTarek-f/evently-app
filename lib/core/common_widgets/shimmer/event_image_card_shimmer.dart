import 'package:evently_app/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventImageCardShimmer extends StatelessWidget {
  const EventImageCardShimmer({
    super.key,
    this.width,
    this.height,
  });
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      width: width ?? ScreenUtil().screenWidth,
      height: height ?? 203.h,
      radius: 16.r,
    );
  }
}

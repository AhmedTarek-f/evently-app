import 'package:evently_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius,
    this.color,
  });
  final double width, height;
  final double? radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode ? AppColors.overDarkBlue : Colors.grey[300]!,
      highlightColor: isDarkMode ? AppColors.whiteGray : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 15.r),
          color:
              color ?? (isDarkMode ? const Color(0xFF4F4F4F) : Colors.white60),
        ),
      ),
    );
  }
}

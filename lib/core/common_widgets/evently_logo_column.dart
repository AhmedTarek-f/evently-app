import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventlyLogoColumn extends StatelessWidget {
  const EventlyLogoColumn({
    super.key,
    this.width,
  });
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            AppImages.eventlyLogo,
            width: width ?? 136.w,
            fit: BoxFit.contain,
          ),
          Text(
            AppText.appName,
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    );
  }
}

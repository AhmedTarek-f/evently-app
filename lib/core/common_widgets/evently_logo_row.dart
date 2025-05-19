import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventlyLogoRow extends StatelessWidget {
  const EventlyLogoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.eventlyLogo,
          width: 48.w,
          fit: BoxFit.cover,
        ),
        const RSizedBox(
          width: 10,
        ),
        Text(
          AppText.appName,
          style: Theme.of(context).textTheme.displaySmall,
        )
      ],
    );
  }
}

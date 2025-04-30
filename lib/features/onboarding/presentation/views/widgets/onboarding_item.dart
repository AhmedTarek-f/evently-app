import 'package:evently_app/features/onboarding/data/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.onboardingData});
  final OnboardingModel onboardingData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RPadding(
          padding: const EdgeInsets.symmetric(vertical: 38.0),
          child: Image.asset(
            onboardingData.image,
            width: ScreenUtil().screenWidth,
            height: 361.h,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          onboardingData.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const RSizedBox(
          height: 38,
        ),
        Expanded(
          child: Text(
            onboardingData.subTitle,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 8,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

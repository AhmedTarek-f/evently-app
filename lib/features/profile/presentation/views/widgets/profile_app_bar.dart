import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/features/profile/presentation/views/widgets/user_profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 204.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            84.r,
          ),
        ),
      ),
      child: SafeArea(
          child: RPadding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 124.r,
              height: 124.r,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1000.r),
                  bottomRight: Radius.circular(1000.r),
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(1000.r),
                ),
                image: const DecorationImage(
                  image: AssetImage(
                    AppImages.routeLogo,
                  ),
                ),
              ),
            ),
            const RSizedBox(width: 16),
            const UserProfileDetails(),
          ],
        ),
      )),
    );
  }
}

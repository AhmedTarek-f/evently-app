import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ProfileCubit>(context);
    return RPadding(
      padding: const EdgeInsets.only(
        right: 16,
        left: 16,
        bottom: 32,
      ),
      child: CustomElevatedButton(
        isText: false,
        onPressed: () async {
          await controller.logout();
        },
        buttonTitle: "",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppIcons.logout,
              width: 24.r,
              height: 24.r,
            ),
            const RSizedBox(width: 8),
            Text(
              AppText.logout.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

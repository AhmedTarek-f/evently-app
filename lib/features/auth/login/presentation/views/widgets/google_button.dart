import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {},
      buttonTitle: "",
      backgroundColor: Colors.transparent,
      borderColor: Theme.of(context).colorScheme.primary,
      isText: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.google),
          const RSizedBox(width: 10),
          Text(
            AppText.loginWithGoogle.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

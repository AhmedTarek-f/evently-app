import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views/widgets/reset_password_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Image.asset(
            AppImages.forgetPassword,
            width: ScreenUtil().screenWidth,
            fit: BoxFit.contain,
          ),
          const RSizedBox(height: 24),
          const ResetPasswordButton(),
        ],
      ),
    );
  }
}

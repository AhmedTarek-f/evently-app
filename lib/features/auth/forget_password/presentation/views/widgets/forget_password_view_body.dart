import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views/widgets/forget_password_email_field.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views/widgets/reset_password_button.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_cubit.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) => current is FormValidationSuccessState,
      listener: (context, state) {
        if (state is FormValidationSuccessState) {}
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Image.asset(
                AppImages.forgetPassword,
                width: ScreenUtil().screenWidth,
                fit: BoxFit.contain,
              ),
              const RSizedBox(height: 24),
              const ForgetPasswordEmailField(),
              const RSizedBox(height: 16),
              const ResetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

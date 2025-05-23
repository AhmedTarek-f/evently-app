import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/loading_circle.dart';
import 'package:evently_app/core/common_widgets/success_screen.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views_model/verify_email_cubit.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views_model/verify_email_state.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views/evently_bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyEmailViewBody extends StatelessWidget {
  const VerifyEmailViewBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<VerifyEmailCubit>(context);
    return BlocListener<VerifyEmailCubit, VerifyEmailState>(
      listenWhen: (previous, current) =>
          current is SendEmailVerificationFailureState ||
          current is SendEmailVerificationSuccessState ||
          current is EmailVerifiedState,
      listener: (context, state) async {
        if (state is SendEmailVerificationFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is SendEmailVerificationSuccessState) {
          Loaders.showSuccessMessage(
            title: Text(
              AppText.emailSent.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.white,
                  ),
            ),
            message: AppText.emailSentMessage,
            context: context,
          );
        } else if (state is EmailVerifiedState) {
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => SuccessScreen(
                    isAnimation: true,
                    image: AppImages.successfullyRegisterAnimation,
                    title: AppText.yourAccountSuccessfullyCreated,
                    subTitle: AppText.yourAccountSuccessfullyCreatedMessage,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        EventlyBottomNavigationView.routeName,
                      );
                    }),
              ),
              (route) => false,
            );
          }
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().screenHeight * 0.0280,
            bottom: ScreenUtil().screenHeight * 0.0280,
            right: ScreenUtil().screenWidth * 0.0611,
            left: ScreenUtil().screenWidth * 0.0611,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.deliveredEmailIllustration,
                width: ScreenUtil().screenWidth * 0.6,
              ),
              const RSizedBox(
                height: 32,
              ),
              Text(
                AppText.verifyYourEmailAddress.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const RSizedBox(
                height: 16,
              ),
              Text(
                controller.email ?? "",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const RSizedBox(
                height: 16,
              ),
              Text(
                AppText.verifyEmailCongratulations.tr(),
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const RSizedBox(
                height: 32,
              ),
              SizedBox(
                width: ScreenUtil().screenWidth,
                child: CustomElevatedButton(
                  onPressed: () =>
                      controller.manuallyCheckEmailVerificationStatus(),
                  buttonTitle: AppText.continueText,
                ),
              ),
              const RSizedBox(
                height: 16,
              ),
              SizedBox(
                width: ScreenUtil().screenWidth,
                child: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                  builder: (context, state) => TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () async =>
                        await controller.sendEmailVerification(),
                    child: state is SendEmailVerificationLoadingState
                        ? const LoadingCircle()
                        : Text(
                            AppText.resendEmail.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:evently_app/core/common_widgets/evently_logo_column.dart';
import 'package:evently_app/core/common_widgets/language_switch_row.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/full_screen_loader.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/auth/register/presentation/views/widgets/already_have_account_row.dart';
import 'package:evently_app/features/auth/register/presentation/views/widgets/create_account_button.dart';
import 'package:evently_app/features/auth/register/presentation/views/widgets/register_form.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_cubit.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_state.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is RegisterLoadingState ||
          current is RegisterFailureState ||
          current is RegisterSuccessState,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          FullScreenLoader.openLoadingDialog(
            text: AppText.processingYourInformation,
            animation: AppImages.loadingAnimation,
            context: context,
          );
        } else if (state is RegisterFailureState) {
          FullScreenLoader.stopLoading(context: context);
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is RegisterSuccessState) {
          FullScreenLoader.stopLoading(context: context);
          Navigator.of(context).pushReplacementNamed(
            VerifyEmailView.routeName,
          );
        }
      },
      child: const SingleChildScrollView(
        child: RPadding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              RSizedBox(height: 32),
              EventlyLogoColumn(),
              RSizedBox(height: 24),
              RegisterForm(),
              RSizedBox(height: 24),
              CreateAccountButton(),
              RSizedBox(height: 14),
              AlreadyHaveAccountRow(),
              RSizedBox(height: 22),
              LanguageSwitchRow(isLanguageTextVisible: false),
            ],
          ),
        ),
      ),
    );
  }
}

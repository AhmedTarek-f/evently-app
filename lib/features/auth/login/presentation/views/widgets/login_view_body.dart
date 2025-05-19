import 'package:evently_app/core/common_widgets/evently_logo_column.dart';
import 'package:evently_app/core/common_widgets/language_switch_row.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/full_screen_loader.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/auth/login/presentation/views/widgets/create_account_row.dart';
import 'package:evently_app/features/auth/login/presentation/views/widgets/forget_password_button.dart';
import 'package:evently_app/features/auth/login/presentation/views/widgets/google_button.dart';
import 'package:evently_app/features/auth/login/presentation/views/widgets/login_button.dart';
import 'package:evently_app/features/auth/login/presentation/views/widgets/login_form.dart';
import 'package:evently_app/features/auth/login/presentation/views/widgets/or_divider.dart';
import 'package:evently_app/features/auth/login/presentation/views_model/login_cubit.dart';
import 'package:evently_app/features/auth/login/presentation/views_model/login_state.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views/verify_email_view.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views/evently_bottom_navigation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginLoadingState ||
          current is LoginFailureState ||
          current is LoginSuccessState,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          FullScreenLoader.openLoadingDialog(
            text: AppText.loggingYouIn,
            animation: AppImages.loadingAnimation,
            context: context,
          );
        } else if (state is LoginFailureState) {
          FullScreenLoader.stopLoading(context: context);
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is LoginSuccessState) {
          FullScreenLoader.stopLoading(context: context);
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            Navigator.of(context).pushReplacementNamed(
              EventlyBottomNavigationView.routeName,
            );
          } else {
            Navigator.of(context).pushReplacementNamed(
              VerifyEmailView.routeName,
            );
          }
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
              LoginForm(),
              RSizedBox(height: 14),
              ForgetPasswordButton(),
              RSizedBox(height: 22),
              LoginButton(),
              RSizedBox(height: 22),
              CreateAccountRow(),
              RSizedBox(height: 22),
              OrDivider(),
              RSizedBox(height: 24),
              GoogleButton(),
              RSizedBox(height: 24),
              LanguageSwitchRow(isLanguageTextVisible: false),
            ],
          ),
        ),
      ),
    );
  }
}

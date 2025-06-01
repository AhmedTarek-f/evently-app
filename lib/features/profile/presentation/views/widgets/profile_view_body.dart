import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/core/utils/loaders/full_screen_loader.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/auth/login/presentation/views/login_view.dart';
import 'package:evently_app/features/profile/presentation/views/widgets/delete_account_button.dart';
import 'package:evently_app/features/profile/presentation/views/widgets/logout_button.dart';
import 'package:evently_app/features/profile/presentation/views/widgets/profile_app_bar.dart';
import 'package:evently_app/features/profile/presentation/views/widgets/user_profile_options.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_cubit.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutLoadingState) {
          FullScreenLoader.openLoadingDialog(
            text: AppText.loggingYouOut,
            animation: AppImages.loadingAnimation,
            context: context,
          );
        } else if (state is LogoutFailureState) {
          FullScreenLoader.stopLoading(context: context);
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is LogoutSuccessState) {
          EventlyMethodsHelper.allEvents.clear();
          FullScreenLoader.stopLoading(context: context);
          Navigator.of(context).pushReplacementNamed(
            LoginView.routeName,
          );
        }
      },
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAppBar(),
          RSizedBox(height: 24),
          UserProfileOptions(),
          Spacer(),
          DeleteAccountButton(),
          LogoutButton()
        ],
      ),
    );
  }
}

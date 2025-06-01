import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/loading_button.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_cubit.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ForgetPasswordCubit>(context);
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      buildWhen: (previous, current) =>
          current is SendResetPasswordLoadingState ||
          current is SendResetPasswordFailureState,
      builder: (context, state) => controller.isLoading
          ? const LoadingButton()
          : CustomElevatedButton(
              onPressed: () async {
                await controller.resetPassword();
              },
              buttonTitle: AppText.resetPassword,
            ),
    );
  }
}

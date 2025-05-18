import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/auth/login/presentation/views_model/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<LoginCubit>(context);
    return CustomElevatedButton(
      onPressed: () async {
        await controller.login();
      },
      buttonTitle: AppText.login,
    );
  }
}

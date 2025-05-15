import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<RegisterCubit>(context);
    return CustomElevatedButton(
      onPressed: () {
        controller.createAccount();
      },
      buttonTitle: AppText.createAccount,
    );
  }
}

import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/auth/login/presentation/views/login_view.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views/widgets/verify_email_view_body.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views_model/verify_email_cubit.dart';
import 'package:evently_app/features/auth/verify_email/presentation/views_model/verify_email_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatelessWidget {
  static const String routeName = "VerifyEmailView";
  const VerifyEmailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<VerifyEmailCubit>(context);
    return BlocListener<VerifyEmailCubit, VerifyEmailState>(
      listenWhen: (previous, current) =>
          current is LogoutSuccessState || current is LogoutSuccessState,
      listener: (context, state) {
        if (state is LogoutFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is LogoutSuccessState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginView.routeName,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async => await controller.logout(),
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        body: const VerifyEmailViewBody(),
      ),
    );
  }
}

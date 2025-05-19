import 'package:evently_app/features/auth/forget_password/presentation/views/widgets/forget_password_app_bar.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views/widgets/forget_password_view_body.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  static const String routeName = "ForgetPasswordView";
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ForgetPasswordAppBar(),
      body: ForgetPasswordViewBody(),
    );
  }
}

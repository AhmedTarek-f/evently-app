import 'package:evently_app/features/auth/login/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "LoginView";
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: LoginViewBody(),
      ),
    );
  }
}

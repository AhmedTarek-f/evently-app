import 'package:evently_app/features/auth/register/presentation/views/widgets/register_view_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  static const String routeName = "RegisterView";
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RegisterViewBody(),
      ),
    );
  }
}

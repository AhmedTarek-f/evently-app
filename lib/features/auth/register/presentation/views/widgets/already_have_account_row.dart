import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/auth/login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlreadyHaveAccountRow extends StatelessWidget {
  const AlreadyHaveAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppText.alreadyHaveAccount,
          style: TextTheme.of(context).titleMedium,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
              LoginView.routeName,
            );
          },
          highlightColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          splashColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(22.r),
          child: RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              AppText.login,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                    decorationColor: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

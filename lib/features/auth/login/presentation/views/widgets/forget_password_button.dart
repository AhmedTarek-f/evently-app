import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            ForgetPasswordView.routeName,
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
            AppText.forgetPassword.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ),
    );
  }
}

import 'package:evently_app/core/common_widgets/custom_text_form_field.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            labelText: AppText.email,
            textInputAction: TextInputAction.next,
            prefixIcon: RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(
                AppIcons.email,
                width: 56.r,
                height: 56.r,
              ),
            ),
          ),
          const RSizedBox(height: 16),
          CustomTextFormField(
            labelText: AppText.password,
            textInputAction: TextInputAction.done,
            prefixIcon: RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(
                AppIcons.passwordLock,
                width: 56.r,
                height: 56.r,
              ),
            ),
            suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.visibility_off,
                  size: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                )),
          ),
        ],
      ),
    );
  }
}

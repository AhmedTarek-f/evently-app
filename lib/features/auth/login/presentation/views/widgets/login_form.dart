import 'package:evently_app/core/common_widgets/custom_text_form_field.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/validations.dart';
import 'package:evently_app/features/auth/login/presentation/views_model/login_cubit.dart';
import 'package:evently_app/features/auth/login/presentation/views_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => current is EnableAutoValidateModeState,
      builder: (context, state) => Form(
        key: controller.loginFormKey,
        autovalidateMode: controller.autoValidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              labelText: AppText.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
              prefixIcon: RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(
                  AppIcons.email,
                  width: 56.r,
                  height: 56.r,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              validator: (value) => Validations.emailValidation(value),
            ),
            const RSizedBox(height: 16),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) => current is ChangeObscureState,
              builder: (context, state) => CustomTextFormField(
                labelText: AppText.password,
                controller: controller.passwordController,
                textInputAction: TextInputAction.done,
                obscureText: controller.isObscure,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    AppIcons.passwordLock,
                    width: 56.r,
                    height: 56.r,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.toggleObscure();
                  },
                  icon: Icon(
                    controller.isObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                validator: (value) => Validations.validatePassword(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

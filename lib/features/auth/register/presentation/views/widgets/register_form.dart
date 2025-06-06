import 'package:evently_app/core/common_widgets/custom_text_form_field.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/validations.dart';
import 'package:evently_app/features/auth/register/presentation/views/widgets/gender_drop_down_button.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_cubit.dart';
import 'package:evently_app/features/auth/register/presentation/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => current is EnableAutoValidateModeState,
      builder: (context, state) => Form(
        key: controller.createAccountFormKey,
        autovalidateMode: controller.autoValidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              labelText: AppText.name,
              textInputAction: TextInputAction.next,
              controller: controller.userNameController,
              keyboardType: TextInputType.name,
              prefixIcon: RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(
                  AppIcons.user,
                  width: 56.r,
                  height: 56.r,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              validator: (value) => Validations.userNameValidation(value),
            ),
            const RSizedBox(height: 16),
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
            const GenderDropDownButtonField(),
            const RSizedBox(height: 16),
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) =>
                  current is ChangePasswordObscureState,
              builder: (context, state) => CustomTextFormField(
                labelText: AppText.password,
                textInputAction: TextInputAction.next,
                controller: controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: controller.isPasswordObscure,
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
                    controller.togglePasswordObscure();
                  },
                  icon: Icon(
                    controller.isPasswordObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                validator: (value) => Validations.validatePassword(value),
              ),
            ),
            const RSizedBox(height: 16),
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) =>
                  current is ChangeConfirmPasswordObscureState,
              builder: (context, state) => CustomTextFormField(
                labelText: AppText.rePassword,
                textInputAction: TextInputAction.done,
                controller: controller.confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: controller.isConfirmPasswordObscure,
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
                    controller.toggleConfirmPasswordObscure();
                  },
                  icon: Icon(
                    controller.isConfirmPasswordObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                validator: (value) => Validations.validateConfirmPassword(
                  value,
                  controller.passwordController.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

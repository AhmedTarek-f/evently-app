import 'package:evently_app/core/common_widgets/custom_text_form_field.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/validations.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_cubit.dart';
import 'package:evently_app/features/auth/forget_password/presentation/views_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordEmailField extends StatelessWidget {
  const ForgetPasswordEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ForgetPasswordCubit>(context);
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      buildWhen: (previous, current) => current is EnableAutoValidateModeState,
      builder: (context, state) => Form(
        key: controller.forgetPasswordFormKey,
        autovalidateMode: controller.autoValidateMode,
        child: CustomTextFormField(
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
      ),
    );
  }
}

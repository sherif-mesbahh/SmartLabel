import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/forgot_password_widgets/forgot_password_code_section_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/forgot_password_widgets/forgot_password_send_code_button_widget.dart';

class ForgotPasswordEmailSection extends StatelessWidget {
  const ForgotPasswordEmailSection({
    super.key,
    required this.emailFormKey,
    required this.emailController,
    required this.codeFormKey,
    required this.codeController,
    required this.passwordFormKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> emailFormKey;
  final TextEditingController emailController;
  final GlobalKey<FormState> codeFormKey;
  final TextEditingController codeController;
  final GlobalKey<FormState> passwordFormKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Email Field
        AppCubit.get(context).codeSent == false
            ? Column(
                children: [
                  Form(
                    key: emailFormKey,
                    child: CustomTextFormFieldWidget(
                      enabled: AppCubit.get(context).codeSent == false
                          ? true
                          : false,
                      controller: emailController,
                      labelText: S.of(context).forgotPasswordEmailLabel,
                      hintText: S.of(context).forgotPasswordEmailHint,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      showSuffixIcon: false,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return S.of(context).forgotPasswordEmailValidation;
                        }
                        return null;
                      },
                      suffixIconOnPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Send Code Button
                  ForgotPasswordSendCodeButton(
                      emailFormKey: emailFormKey,
                      emailController: emailController),
                ],
              )
            : SizedBox(),
        AppCubit.get(context).codeSent == true
            ? ForgotPasswordCodeSection(
                codeFormKey: codeFormKey,
                codeController: codeController,
                emailFormKey: emailFormKey,
                emailController: emailController,
                passwordFormKey: passwordFormKey,
                newPasswordController: newPasswordController,
                confirmPasswordController: confirmPasswordController)
            : SizedBox(),
      ],
    );
  }
}

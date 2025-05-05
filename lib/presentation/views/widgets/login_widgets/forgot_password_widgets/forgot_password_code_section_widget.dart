import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/forgot_password_widgets/forgot_password_check_code_button_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/forgot_password_widgets/forgot_password_passwords_section_widget.dart';

class ForgotPasswordCodeSection extends StatelessWidget {
  const ForgotPasswordCodeSection({
    super.key,
    required this.codeFormKey,
    required this.codeController,
    required this.emailFormKey,
    required this.emailController,
    required this.passwordFormKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> codeFormKey;
  final TextEditingController codeController;
  final GlobalKey<FormState> emailFormKey;
  final TextEditingController emailController;
  final GlobalKey<FormState> passwordFormKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppCubit.get(context).codeVerified == false
              ? Column(
                  children: [
                    Form(
                      key: codeFormKey,
                      child: CustomTextFormFieldWidget(
                        enabled: AppCubit.get(context).codeVerified == false
                            ? true
                            : false,
                        controller: codeController,
                        hintText: 'Enter your code',
                        labelText: 'Code',
                        obscureText: false,
                        suffixIconOnPressed: () {},
                        keyboardType: TextInputType.number,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter your code';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Check Code Button
                    ForgotPasswordCheckCodeButton(
                        emailFormKey: emailFormKey,
                        codeFormKey: codeFormKey,
                        emailController: emailController,
                        codeController: codeController),
                  ],
                )
              : SizedBox(),
          // Code Field

          AppCubit.get(context).codeVerified == true
              ? ForgotPasswordPasswordsSection(
                  passwordFormKey: passwordFormKey,
                  newPasswordController: newPasswordController,
                  confirmPasswordController: confirmPasswordController,
                  emailFormKey: emailFormKey,
                  emailController: emailController)
              : SizedBox(),
        ],
      ),
    );
  }
}

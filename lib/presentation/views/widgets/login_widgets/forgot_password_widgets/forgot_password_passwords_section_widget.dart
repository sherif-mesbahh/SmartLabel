import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class ForgotPasswordPasswordsSection extends StatefulWidget {
  const ForgotPasswordPasswordsSection({
    super.key,
    required this.passwordFormKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.emailFormKey,
    required this.emailController,
  });

  final GlobalKey<FormState> passwordFormKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> emailFormKey;
  final TextEditingController emailController;

  @override
  State<ForgotPasswordPasswordsSection> createState() =>
      _ForgotPasswordPasswordsSectionState();
}

class _ForgotPasswordPasswordsSectionState
    extends State<ForgotPasswordPasswordsSection> {
  bool hasUpper = false;
  bool hasLower = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;

  final RegExp specialCharExp = RegExp(r'[!@#$%^&*(),.?_":{}|<>]');

  void validatePassword(String value) {
    setState(() {
      hasUpper = RegExp(r'[A-Z]').hasMatch(value);
      hasLower = RegExp(r'[a-z]').hasMatch(value);
      hasNumber = RegExp(r'[0-9]').hasMatch(value);
      hasSpecialChar = specialCharExp.hasMatch(value);
      hasMinLength = value.length >= 8;
    });
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your new password';
    }
    if (value.length < 8) return 'Must be at least 8 characters long';
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Must contain an uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Must contain a lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Must contain a number';
    if (!specialCharExp.hasMatch(value)) {
      return 'Must contain a special character';
    }
    return null;
  }

  String? confirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your confirm password';
    }
    if (value != widget.newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Form(
        key: widget.passwordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // New Password Field
            CustomTextFormFieldWidget(
              controller: widget.newPasswordController,
              hintText: 'Enter your new password',
              labelText: 'New Password',
              obscureText: false,
              suffixIconOnPressed: () {},
              keyboardType: TextInputType.visiblePassword,
              onChanged: validatePassword,
              validator: passwordValidator,
            ),
            const SizedBox(height: 10),

            // Password Strength Indicators
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Wrap(
                  runSpacing: 6,
                  children: [
                    PasswordStrengthIndicator(
                      isValid: hasUpper,
                      text: 'Must contain an uppercase letter (A-Z)',
                    ),
                    PasswordStrengthIndicator(
                      isValid: hasLower,
                      text: 'Must contain a lowercase letter (a-z)',
                    ),
                    PasswordStrengthIndicator(
                      isValid: hasNumber,
                      text: 'Must contain a number (0-9)',
                    ),
                    PasswordStrengthIndicator(
                      isValid: hasSpecialChar,
                      text: 'Must contain a special character e.g. !@#',
                    ),
                    PasswordStrengthIndicator(
                      isValid: hasMinLength,
                      text: 'Must be at least 8 characters long',
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Confirm Password Field
            CustomTextFormFieldWidget(
              controller: widget.confirmPasswordController,
              hintText: 'Enter your confirm password',
              labelText: 'Confirm Password',
              obscureText: false,
              suffixIconOnPressed: () {},
              keyboardType: TextInputType.visiblePassword,
              validator: confirmValidator,
            ),
            const SizedBox(height: 10),

            // Submit Button
            Container(
              height: screenHeight(context) * .07,
              width: screenWidth(context) * .2,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  if (widget.passwordFormKey.currentState!.validate()) {
                    AppCubit.get(context).forgotPasswordChangePassword(
                      email: widget.emailController.text.trim(),
                      password: widget.newPasswordController.text.trim(),
                      confirmPassword:
                          widget.confirmPasswordController.text.trim(),
                    );
                  }
                },
                child: BlocConsumer<AppCubit, AppStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child:
                              state is ForgotPasswordChangePasswordLoadingState
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: secondaryColor,
                                      ),
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyles.buttonText(context),
                                      textAlign: TextAlign.center,
                                    ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  final bool isValid;
  final String text;

  const PasswordStrengthIndicator({
    super.key,
    required this.isValid,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 14,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isValid ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

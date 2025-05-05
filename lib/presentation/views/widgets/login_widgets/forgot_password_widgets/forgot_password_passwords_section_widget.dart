import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class ForgotPasswordPasswordsSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Form(
        key: passwordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // New Password Field
            CustomTextFormFieldWidget(
              controller: newPasswordController,
              hintText: 'Enter your new password',
              labelText: 'New Password',
              obscureText: false,
              suffixIconOnPressed: () {},
              keyboardType: TextInputType.visiblePassword,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please enter your new password';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            // Confirm Password Field
            CustomTextFormFieldWidget(
              controller: confirmPasswordController,
              hintText: 'Enter your confirm password',
              labelText: 'Confirm Password',
              obscureText: false,
              suffixIconOnPressed: () {},
              keyboardType: TextInputType.visiblePassword,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please enter your confirm password';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            // Change Password Button
            Container(
              height: screenHeight(context) * .07,
              width: screenWidth(context) * .2,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  if (passwordFormKey.currentState!.validate()) {
                    AppCubit.get(context).forgotPasswordChangePassword(
                      email: emailController.text,
                      password: newPasswordController.text,
                      confirmPassword: confirmPasswordController.text,
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
                                      style: TextStyles.buttonText,
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

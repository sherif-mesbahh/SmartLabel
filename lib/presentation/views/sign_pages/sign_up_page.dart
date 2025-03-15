import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_categories_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight(context) * .3,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/smart_label_logo.png',
                height: screenHeight(context) * .2,
              ),
            ),
          ),
          Container(
            height: screenHeight(context) * .7,
            decoration: BoxDecoration(
              color: secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormFieldWidget(
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    suffixIconOnPressed: () {},
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormFieldWidget(
                    controller: passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    suffixIconOnPressed: () {},
                  ),
                  const SizedBox(height: 16.0),
                  CustomButtonWidget(
                    textColor: secondaryColor,
                    onTap: () {
                      pushNavigator(context, AdminCategoriesPage());
                    },
                    text: 'Sign up',
                    color: primaryColor,
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    child: Text(
                      'go back',
                      style: TextStyles.smallText,
                    ),
                    onPressed: () {
                      popNavigator(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

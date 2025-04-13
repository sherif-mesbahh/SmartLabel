import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/login_page.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_up_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              'assets/images/smart_label_logo.png',
              height: screenHeight(context) * .25,
            ),
            Spacer(),
            // Sign in Button
            CustomButtonWidget(
              textColor: primaryColor,
              onTap: () {
                pushNavigator(context, LoginPage(), slideRightToLeft);
              },
              text: 'Sign in',
              color: secondaryColor,
            ),
            // Sign up Button
            CustomButtonWidget(
              color: primaryColor,
              onTap: () {
                pushNavigator(context, SignUpPage(), slideLeftToRigth);
              },
              text: 'Sign up',
              textColor: secondaryColor,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

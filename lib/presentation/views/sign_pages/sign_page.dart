import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/login_page.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_up_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider(
        create: (context) => AppCubit(),
        child: Center(
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
                onTap: () {
                  pushNavigator(context, LoginPage(), slideRightToLeft);
                },
                color: secondaryColor,
                child: Text(
                  'Sign in',
                  style: TextStyles.buttonText.copyWith(color: primaryColor),
                ),
              ),
              // Sign up Button
              CustomButtonWidget(
                color: primaryColor,
                onTap: () {
                  pushNavigator(context, SignUpPage(), slideLeftToRigth);
                },
                child: Text(
                  'Sign up',
                  style: TextStyles.buttonText.copyWith(color: secondaryColor),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

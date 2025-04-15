import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/layout.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

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
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                color: secondaryColor,
                padding: const EdgeInsets.all(32.0),
                child: BlocConsumer<AppCubit, AppStates>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      navigatorAndRemove(context, Layout(), slideRightToLeft);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                    if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextFormFieldWidget(
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
                            controller: emailController,
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextFormFieldWidget(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            obscureText:
                                AppCubit.get(context).loginIsPasswordObscured,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            suffixIconOnPressed: () {
                              AppCubit.get(context)
                                  .changeLoginPasswordVisibility();
                            },
                            showSuffixIcon: true,
                            suffixIcon:
                                AppCubit.get(context).loginPasswordSuffix,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 16.0),
                          CustomButtonWidget(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).login(
                                  data: {
                                    "email": emailController.text,
                                    "password": passwordController.text,
                                  },
                                );
                              }
                            },
                            color: primaryColor,
                            child: state is LoginLoadingState
                                ? const CircularProgressIndicator(
                                    color: secondaryColor,
                                  )
                                : Text(
                                    'Sign in',
                                    style: TextStyles.buttonText
                                        .copyWith(color: secondaryColor),
                                  ),
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
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

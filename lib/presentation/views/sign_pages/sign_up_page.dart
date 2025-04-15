import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight(context) * 0.3,
            decoration: const BoxDecoration(color: primaryColor),
            child: Center(
              child: Image.asset(
                'assets/images/smart_label_logo.png',
                height: screenHeight(context) * 0.2,
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
                    if (state is RegisterSuccessState) {
                      navigatorAndRemove(context, SignPage(), slideRightToLeft);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Register Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                    if (state is RegisterErrorState) {
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
                      child: BlocBuilder<AppCubit, AppStates>(
                        buildWhen: (previous, current) {
                          return current is RegisterLoadingState ||
                              current is RegisterSuccessState ||
                              current is RegisterErrorState;
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              CustomTextFormFieldWidget(
                                controller: firstNameController,
                                labelText: 'First Name',
                                hintText: 'Enter your first name',
                                obscureText: false,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter your first name'
                                        : null,
                                suffixIconOnPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              CustomTextFormFieldWidget(
                                controller: lastNameController,
                                labelText: 'Last Name',
                                hintText: 'Enter your last name',
                                obscureText: false,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter your last name'
                                        : null,
                                suffixIconOnPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              CustomTextFormFieldWidget(
                                controller: emailController,
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                obscureText: false,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter your email'
                                        : null,
                                suffixIconOnPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              CustomTextFormFieldWidget(
                                controller: passwordController,
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                obscureText: true,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter your password'
                                        : null,
                                suffixIconOnPressed: () {},
                              ),
                              const SizedBox(height: 16.0),
                              CustomTextFormFieldWidget(
                                controller: confirmPasswordController,
                                labelText: 'Confirm Password',
                                hintText: 'Enter your confirm password',
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your confirm password';
                                  }
                                  return null;
                                },
                                suffixIconOnPressed: () {},
                              ),
                              const SizedBox(height: 24.0),
                              CustomButtonWidget(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).register(data: {
                                      "firstName": firstNameController.text,
                                      "lastName": lastNameController.text,
                                      "email": emailController.text,
                                      "password": passwordController.text,
                                      "confirmPassword":
                                          confirmPasswordController.text,
                                    });
                                  }
                                },
                                color: primaryColor,
                                child: Text(
                                  'Sign up',
                                  style: TextStyles.buttonText
                                      .copyWith(color: secondaryColor),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              TextButton(
                                onPressed: () => popNavigator(context),
                                child: Text('go back',
                                    style: TextStyles.smallText),
                              ),
                            ],
                          );
                        },
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

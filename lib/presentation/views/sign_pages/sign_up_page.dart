import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
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

  bool hasUpper = false;
  bool hasLower = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;

  final RegExp specialCharExp = RegExp(r'[!@#$%^&*(),.?"_:{}|<>]');

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
      return S.of(context).signupPasswordValidation;
    }
    if (value.length < 8) return S.of(context).passwordValidationMinLength;
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return S.of(context).passwordValidationUpperCase;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return S.of(context).passwordValidationLowerCase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return S.of(context).passwordValidationNumber;
    }
    if (!specialCharExp.hasMatch(value)) {
      return S.of(context).passwordValidationSpecialChar;
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).signupConfirmPasswordValidation;
    }
    if (value != passwordController.text) {
      return S.of(context).signupConfirmPasswordDontMatchValidation;
    }
    return null;
  }

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(32.0),
                child: BlocConsumer<AppCubit, AppStates>(
                  listener: (context, state) {
                    if (state is RegisterSuccessState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      navigatorAndRemove(context, SignPage(), slideRightToLeft);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S
                                .of(context)
                                .registrationsuccessfulWehavesentaconfirmationemailtoyouraddress,
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                    if (state is RegisterErrorState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    if (state is RegisterLoadingState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Center(
                          child: Lottie.asset(
                            'assets/lottie/loading_indicator.json',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormFieldWidget(
                            keyboardType: TextInputType.name,
                            controller: firstNameController,
                            labelText: S.of(context).signupFirstNameLabel,
                            hintText: S.of(context).signupFirstNameHint,
                            obscureText: false,
                            validator: (value) => value == null || value.isEmpty
                                ? S.of(context).signupFirstNameValidation
                                : null,
                            suffixIconOnPressed: () {},
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextFormFieldWidget(
                            keyboardType: TextInputType.name,
                            controller: lastNameController,
                            labelText: S.of(context).signupLastNameLabel,
                            hintText: S.of(context).signupLastNameHint,
                            obscureText: false,
                            validator: (value) => value == null || value.isEmpty
                                ? S.of(context).signupLastNameValidation
                                : null,
                            suffixIconOnPressed: () {},
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextFormFieldWidget(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            labelText: S.of(context).signupEmailLabel,
                            hintText: S.of(context).signupEmailHint,
                            obscureText: false,
                            validator: (value) => value == null || value.isEmpty
                                ? S.of(context).signupEmailValidation
                                : null,
                            suffixIconOnPressed: () {},
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextFormFieldWidget(
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            labelText: S.of(context).signupPasswordLabel,
                            hintText: S.of(context).signupPasswordHint,
                            obscureText:
                                AppCubit.get(context).signUpIsPasswordObscured,
                            onChanged: validatePassword,
                            validator: passwordValidator,
                            suffixIconOnPressed: () {
                              AppCubit.get(context)
                                  .changeSignUpPasswordVisibility();
                            },
                            suffixIcon:
                                AppCubit.get(context).signUpPasswordSuffix,
                            showSuffixIcon: true,
                          ),
                          const SizedBox(height: 10),

                          // Password Strength Indicators
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                runSpacing: 6,
                                children: [
                                  PasswordStrengthIndicator(
                                    isValid: hasUpper,
                                    text: S
                                        .of(context)
                                        .passwordValidationUpperCase,
                                  ),
                                  PasswordStrengthIndicator(
                                    isValid: hasLower,
                                    text: S
                                        .of(context)
                                        .passwordValidationLowerCase,
                                  ),
                                  PasswordStrengthIndicator(
                                    isValid: hasNumber,
                                    text:
                                        S.of(context).passwordValidationNumber,
                                  ),
                                  PasswordStrengthIndicator(
                                    isValid: hasSpecialChar,
                                    text: S
                                        .of(context)
                                        .passwordValidationSpecialChar,
                                  ),
                                  PasswordStrengthIndicator(
                                    isValid: hasMinLength,
                                    text: S
                                        .of(context)
                                        .passwordValidationMinLength,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 16.0),
                          CustomTextFormFieldWidget(
                            keyboardType: TextInputType.visiblePassword,
                            controller: confirmPasswordController,
                            labelText: S.of(context).signupConfirmPasswordLabel,
                            hintText: S.of(context).signupConfirmPasswordHint,
                            obscureText: AppCubit.get(context)
                                .signUpIsConfirmPasswordObscured,
                            showSuffixIcon: true,
                            suffixIcon: AppCubit.get(context)
                                .signUpConfirmPasswordSuffix,
                            suffixIconOnPressed: () {
                              AppCubit.get(context)
                                  .changeSignUpConfirmPasswordVisibility();
                            },
                            validator: confirmPasswordValidator,
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
                              S.of(context).signupButton,
                              style: TextStyles.buttonText(context)
                                  .copyWith(color: secondaryColor),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextButton(
                            onPressed: () => popNavigator(context),
                            child: Text(
                              S.of(context).signupGoBackButton,
                              style: TextStyles.smallText(context),
                            ),
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

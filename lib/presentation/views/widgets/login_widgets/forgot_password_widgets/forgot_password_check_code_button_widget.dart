import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class ForgotPasswordCheckCodeButton extends StatelessWidget {
  const ForgotPasswordCheckCodeButton({
    super.key,
    required this.emailFormKey,
    required this.codeFormKey,
    required this.emailController,
    required this.codeController,
  });

  final GlobalKey<FormState> emailFormKey;
  final GlobalKey<FormState> codeFormKey;
  final TextEditingController emailController;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * .07,
      width: screenWidth(context) * .2,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          if (codeFormKey.currentState!.validate()) {
            AppCubit.get(context).forgotPasswordVerifyCode(
              email: emailController.text,
              code: codeController.text,
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
                  child: state is ForgotPasswordVerifyCodeLoadingState
                      ? Center(
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
                        )
                      : Text(
                          S.of(context).forgotPasswordSubmitButton,
                          style: TextStyles.buttonText(context),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

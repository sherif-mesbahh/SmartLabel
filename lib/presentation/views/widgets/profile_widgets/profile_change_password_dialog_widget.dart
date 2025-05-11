import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class ChangePasswordDialogWidget extends StatefulWidget {
  const ChangePasswordDialogWidget({super.key});

  @override
  State<ChangePasswordDialogWidget> createState() =>
      _ChangePasswordDialogWidgetState();
}

class _ChangePasswordDialogWidgetState
    extends State<ChangePasswordDialogWidget> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  String newPassword = '';
  bool hasUpper = false;
  bool hasLower = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool hasSpecialChar = false;

  final RegExp _specialCharExp = RegExp(r'[!@#$%^&*(),.?"_:{}|<>]');

  void validatePassword(String value) {
    setState(() {
      newPassword = value;
      hasUpper = RegExp(r'[A-Z]').hasMatch(value);
      hasLower = RegExp(r'[a-z]').hasMatch(value);
      hasNumber = RegExp(r'[0-9]').hasMatch(value);
      hasSpecialChar = _specialCharExp.hasMatch(value);

      hasMinLength = value.length >= 8;
    });
  }

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(S.of(context).profilePageChangePasswordTitle,
          style: TextStyles.headline2(context)),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Current Password
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: currentPasswordController,
              decoration: InputDecoration(
                labelText: S.of(context).profilePageChangePasswordCurrentPasswordLabel,
                labelStyle: TextStyles.smallText(context),
                hintStyle: TextStyles.smallText(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // New Password
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: newPasswordController,
              onChanged: validatePassword,
              decoration: InputDecoration(
                labelText: S.of(context).profilePageChangePasswordNewPasswordLabel,
                labelStyle: TextStyles.smallText(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Wrap(
                  runSpacing: 6,
                  children: [
                    _buildRequirementText(
                      S.of(context).passwordValidationMinLength,
                      hasMinLength,
                    ),
                    _buildRequirementText(
                      S.of(context).passwordValidationUpperCase,
                      hasUpper,
                    ),
                    _buildRequirementText(
                      S.of(context).passwordValidationLowerCase,
                      hasLower,
                    ),
                    _buildRequirementText(
                      S.of(context).passwordValidationNumber,
                      hasNumber,
                    ),
                    _buildRequirementText(
                        S.of(context).passwordValidationSpecialChar,
                        hasSpecialChar),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Confirm Password
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: S.of(context).profilePageChangePasswordConfirmPasswordLabel,
                labelStyle: TextStyles.smallText(context),
                hintStyle: TextStyles.smallText(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).cancelButton, style: TextStyles.productTitle(context)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is ChangePasswordSuccessState) {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: S.of(context).passwordChangedSuccessfully,
                backgroundColor: Colors.green,
                textColor: secondaryColor,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 16,
              );
            }
            if (state is ChangePasswordErrorState) {
              Fluttertoast.showToast(
                msg: state.error,
                backgroundColor: Colors.red,
                textColor: secondaryColor,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 16,
              );
            }
          },
          builder: (context, state) {
            final canSubmit = hasUpper && hasLower && hasNumber && hasMinLength;
            return state is ChangePasswordLoadingState
                ? Lottie.asset(
                    'assets/lottie/loading_indicator.json',
                    width: 50,
                    height: 50,
                  )
                : TextButton(
                    onPressed: canSubmit
                        ? () {
                            AppCubit.get(context).changePassword(
                              currentPassword:
                                  currentPasswordController.text.trim(),
                              newPassword: newPasswordController.text.trim(),
                              confirmPassword:
                                  confirmPasswordController.text.trim(),
                            );
                          }
                        : null,
                    child:
                        Text(S.of(context).saveButton, style: TextStyles.productTitle(context)),
                  );
          },
        ),
      ],
    );
  }

  Widget _buildRequirementText(String text, bool isValid) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 12,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: isValid ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

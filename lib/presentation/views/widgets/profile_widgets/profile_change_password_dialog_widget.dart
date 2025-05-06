import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
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
      title: Text('Change Password', style: TextStyles.headline2(context)),
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
                labelText: 'Current Password',
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
              decoration: InputDecoration(
                labelText: 'New Password',
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
            // Confirm Password
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
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
          child: Text('Cancel', style: TextStyles.productTitle(context)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is ChangePasswordSuccessState) {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: 'Password changed successfully',
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
            return state is ChangePasswordLoadingState
                ? Lottie.asset(
                    'assets/lottie/loading_indicator.json',
                    width: 50,
                    height: 50,
                  )
                : TextButton(
                    child:
                        Text('Save', style: TextStyles.productTitle(context)),
                    onPressed: () {
                      AppCubit.get(context).changePassword(
                        currentPassword: currentPasswordController.text.trim(),
                        newPassword: newPasswordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),
                      );
                    },
                  );
          },
        ),
      ],
    );
  }
}

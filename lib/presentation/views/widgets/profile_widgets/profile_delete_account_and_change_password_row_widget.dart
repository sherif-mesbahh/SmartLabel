import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_change_password_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_delete_account_dialog_widget.dart';

class ChangePasswordAndDeleleAccountWidget extends StatelessWidget {
  const ChangePasswordAndDeleleAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Change Password
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ChangePasswordDialogWidget(),
            );
          },
          child: Text(
            S.of(context).profilePageChangePasswordButton,
            style: TextStyles.buttonText(context).copyWith(
              color: primaryColor,
              fontSize: 14,
            ),
          ),
        ),
        // Delete Account
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DeleteAccountDialogWidget(),
            );
          },
          child: Text(
            S.of(context).profilePageDeleteAccountButton,
            style: TextStyles.buttonText(context).copyWith(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

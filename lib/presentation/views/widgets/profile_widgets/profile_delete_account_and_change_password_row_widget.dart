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
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            backgroundColor: primaryColor.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            foregroundColor: primaryColor,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ChangePasswordDialogWidget(),
            );
          },
          child: Text(
            S.of(context).profilePageChangePasswordButton,
            style: TextStyles.buttonText(context).copyWith(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Delete Account
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            backgroundColor: Colors.red.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            foregroundColor: Colors.red,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DeleteAccountDialogWidget(),
            );
          },
          child: Text(
            S.of(context).profilePageDeleteAccountButton,
            style: TextStyles.buttonText(context).copyWith(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

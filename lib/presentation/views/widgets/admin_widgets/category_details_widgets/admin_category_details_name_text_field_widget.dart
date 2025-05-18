import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';

class AdminCategoryDetailsNameTextFieldWidget extends StatelessWidget {
  const AdminCategoryDetailsNameTextFieldWidget({
    super.key,
    required this.nameController,
    required this.formKey,
  });

  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).categoryDialogNameValidation;
        } else if (value.length < 3) {
          return S.of(context).categoryDialogNameLengthValidation;
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: nameController,
      decoration: InputDecoration(
        labelText: S.of(context).editCategoryName,
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
    );
  }
}

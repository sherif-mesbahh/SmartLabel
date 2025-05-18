import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';

class BannerDetailsTitleTextField extends StatelessWidget {
  const BannerDetailsTitleTextField({
    super.key,
    required this.titleController,
    required this.formKey,
  });

  final TextEditingController titleController;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).bannerTitleValidation;
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: titleController,
      decoration: InputDecoration(
        labelText: S.of(context).editBannerTitleText,
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

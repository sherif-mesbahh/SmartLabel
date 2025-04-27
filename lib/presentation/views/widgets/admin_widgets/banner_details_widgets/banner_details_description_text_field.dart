import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class BannerDetailsDescriptionTextField extends StatelessWidget {
  const BannerDetailsDescriptionTextField({
    super.key,
    required this.descController,
  });

  final TextEditingController descController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: descController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: TextStyles.smallText,
        hintStyle: TextStyles.smallText,
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

import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final IconData suffixIcon;
  final VoidCallback suffixIconOnPressed;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomTextFormFieldWidget({
    super.key,
    this.suffixIcon = Icons.visibility,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.suffixIconOnPressed,
    this.validator,
    required this.controller,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: obscureText
            ? IconButton(
                onPressed: suffixIconOnPressed,
                icon: Icon(suffixIcon),
              )
            : null,
        suffixIconColor: primaryColor,
        hintText: hintText,
        hintStyle: TextStyles.smallText,
        labelText: labelText,
        labelStyle: TextStyles.smallText,
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
      validator: validator,
    );
  }
}

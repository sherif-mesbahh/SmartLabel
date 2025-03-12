import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class CustomButtonWidget extends StatelessWidget {
  final Color textColor;

  final VoidCallback onTap;

  final String text;

  final Color color;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * .07,
      width: screenWidth(context) * .9,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: TextStyles.buttonText.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

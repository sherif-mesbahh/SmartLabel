import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  final Widget child;
  final Color color;

  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.child,
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
            child: child,
          ),
        ),
      ),
    );
  }
}

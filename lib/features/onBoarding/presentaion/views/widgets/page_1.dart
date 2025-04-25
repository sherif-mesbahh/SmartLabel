import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.4, // Image takes 80% of screen width
      height: screenWidth(context) * 0.4, // Keep the image square
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/onBoarding_1.jpg'), // Replace with your image
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

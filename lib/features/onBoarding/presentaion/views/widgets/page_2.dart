import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.8, // Image takes 80% of screen width
      height: screenWidth(context) * 0.8, // Keep the image square
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/onBoarding_2.jpg'), // Replace with your image
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

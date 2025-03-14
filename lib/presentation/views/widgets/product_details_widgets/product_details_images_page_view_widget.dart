import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class ProductImagesPageView extends StatelessWidget {
  const ProductImagesPageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * .3,
      child: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          return Image.asset(
            'assets/images/fruits_image.jpg',
            fit: BoxFit.cover,
          );
        },
        itemCount: 10,
      ),
    );
  }
}

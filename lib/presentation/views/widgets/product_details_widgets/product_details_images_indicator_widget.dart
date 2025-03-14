import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsImagesIndicator extends StatelessWidget {
  const ProductDetailsImagesIndicator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SmoothPageIndicator(
        controller: pageController,
        count: 10,
        effect: ExpandingDotsEffect(
          activeDotColor: primaryColor,
          dotColor: greyColor,
          dotHeight: 8,
          dotWidth: 8,
        ),
      ),
    );
  }
}


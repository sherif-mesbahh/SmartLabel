import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsImagesIndicator extends StatelessWidget {
  final List<String> images;
  const ProductDetailsImagesIndicator({
    super.key,
    required this.pageController,
    required this.images,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SmoothPageIndicator(
        controller: pageController,
        count: images.length,
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


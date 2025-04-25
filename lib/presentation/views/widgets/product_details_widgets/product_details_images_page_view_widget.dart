import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class ProductImagesPageView extends StatelessWidget {
  final List<String> images;
  final PageController pageController;

  const ProductImagesPageView({
    super.key,
    required this.pageController,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * .3,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final imageUrl = images[index];

          // Handle null or empty image path
          if (imageUrl.isEmpty || imageUrl.toLowerCase().contains('formfile')) {
            return const Center(
              child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
            );
          }

          return CachedNetworkImage(
            imageUrl: 'http://smartlabel1.runasp.net/Uploads/$imageUrl',
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: Lottie.asset(
                'assets/lottie/loading_indicator.json',
                width: 100,
                height: 100,
              ),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}

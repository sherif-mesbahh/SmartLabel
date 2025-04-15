import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class ActiveBannerDetailsImageSlider extends StatelessWidget {
  const ActiveBannerDetailsImageSlider({
    super.key,
    required this.bannerImages,
  });

  final List<String> bannerImages;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight(context) * .3,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 2.0,
        initialPage: 0,
        enableInfiniteScroll: true,
      ),
      items: bannerImages.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: screenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: "http://smartlabel1.runasp.net/Uploads/$imageUrl",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

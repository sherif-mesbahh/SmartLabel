import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/full_screen_image.dart';

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
        autoPlay: bannerImages.length > 1,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 2.0,
        initialPage: 0,
        enableInfiniteScroll: true,
      ),
      items: bannerImages.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImagePage(
                      imageUrl: Uri.encodeFull(
                          'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(imageUrl)}'),
                    ),
                  ),
                );
              },
              child: Container(
                width: screenWidth(context),
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: Uri.encodeFull(
                              'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(imageUrl)}'),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: Lottie.asset(
                              'assets/lottie/loading_indicator.json',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image),
                        )
                      : const Icon(Icons.image_not_supported, size: 60),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

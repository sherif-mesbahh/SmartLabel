import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/active_banner_details_page.dart';

class CustomSlider extends StatefulWidget {
  final List<dynamic> banners;

  const CustomSlider({
    super.key,
    required this.banners,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int _currentIndex = 0;
  bool _isLoading = false;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return SizedBox(
        height: screenHeight(context) * 0.25,
        child: Center(
          child: Text(
            'No banners available',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller, // <-- add controller here

          itemCount: widget.banners.length,
          itemBuilder: (context, index, realIndex) {
            final banner = widget.banners[index];
            return GestureDetector(
              onTap: _isLoading
                  ? null
                  : () async {
                      setState(() => _isLoading = true);

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Lottie.asset(
                              'assets/lottie/loading_indicator.json',
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                      );

                      await AppCubit.get(context)
                          .getActiveBannerDetails(id: banner.id ?? 1);

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }

                      if (context.mounted) {
                        pushNavigator(
                          context,
                          ActiveBannerDetailsPage(id: banner.id ?? 1),
                          slideRightToLeft,
                        );
                      }

                      setState(() => _isLoading = false);
                    },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl:
                        "http://smartlabel1.runasp.net/Uploads/${banner.mainImage}",
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 500),
                    placeholder: (context, url) => Center(
                      child: Lottie.asset(
                        'assets/lottie/loading_indicator.json',
                        width: 70,
                        height: 70,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.broken_image,
                                size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              'Image not available',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    imageBuilder: (context, imageProvider) => Semantics(
                      label: 'Banner Image',
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: screenHeight(context) * 0.25,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            aspectRatio: 16 / 9,
            initialPage: 0,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller
                  .animateToPage(entry.key), // <-- use controller here
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: _currentIndex == entry.key ? 14 : 10,
                height: _currentIndex == entry.key ? 14 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? primaryColor
                      : Colors.grey.shade400,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_banner_details_page.dart';

class AdminCustomSliderWidget extends StatelessWidget {
  final AppCubit cubit;

  const AdminCustomSliderWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final banners = cubit.bannersModel?.data ?? [];
    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight(context) * .3,
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 2.0,
        initialPage: 0,
        enableInfiniteScroll: false,
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                );

                await AppCubit.get(context)
                    .getBannerDetails(id: banner.id ?? 1);

                if (context.mounted) {
                  Navigator.of(context).pop();
                }

                if (context.mounted) {
                  pushNavigator(
                    context,
                    AdminBannerDetailsPage(id: banner.id ?? 1),
                    slideRightToLeft,
                  );
                }
              },
              child: Stack(
                children: [
                  Container(
                    width: screenWidth(context),
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://smartlabel1.runasp.net/Uploads/${banner.mainImage}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  ),

                  // 🔴 Positioned Delete Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        cubit.deleteBanner(id: banner.id!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

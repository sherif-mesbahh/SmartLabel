import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_image_model.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AdminBannerDetailsImagesSliderWidget extends StatelessWidget {
  const AdminBannerDetailsImagesSliderWidget({
    super.key,
    required this.bannerImages,
    required this.banner,
  });

  final List<BannerDatailsDataImageModel> bannerImages;
  final BannerDetailsDataModel banner;

  @override
  Widget build(BuildContext context) {
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
      items: bannerImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                return Stack(
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
                        child: image.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl:
                                    "http://smartlabel1.runasp.net/Uploads/${image.imageUrl}",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.broken_image),
                              )
                            : const Icon(Icons.image_not_supported, size: 60),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.white, size: 20),
                          onPressed: () {
                            AppCubit.get(context).deleteBannerDetailsImage(
                              bannerId: banner.id!,
                              title: banner.title!,
                              description: banner.description!,
                              startDate: "${banner.startDate}",
                              endDate: "${banner.endDate}",
                              mainImage: banner.mainImage!,
                              imageId: image.imageId!,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      }).toList(),
    );
  }
}

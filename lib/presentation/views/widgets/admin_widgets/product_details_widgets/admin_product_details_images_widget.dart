import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/full_screen_image.dart';
import 'package:smart_label_software_engineering/models/product_details_model/product_details_data_images_model.dart';
import 'package:smart_label_software_engineering/models/product_details_model/product_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class ProductDetailsImagesWidget extends StatefulWidget {
  const ProductDetailsImagesWidget({
    super.key,
    required this.productImages,
    required this.product,
  });

  final List<ProductDetailsDataImagesModel> productImages;
  final ProductDetailsDataModel product;

  @override
  State<ProductDetailsImagesWidget> createState() =>
      _AdminProductDetailsImagesWidgetState();
}

class _AdminProductDetailsImagesWidgetState
    extends State<ProductDetailsImagesWidget> {
  final Set<int> deletedImageIds = {};

  @override
  Widget build(BuildContext context) {
    final filteredImages = widget.productImages
        .where((img) => !deletedImageIds.contains(img.imageId))
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight(context) * .25,
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 2.0,
        initialPage: 0,
        enableInfiniteScroll: false,
      ),
      items: filteredImages.map((image) {
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
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullScreenImagePage(
                                        imageUrl:
                                            "http://smartlabel1.runasp.net/Uploads/${image.imageUrl}",
                                      ),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "http://smartlabel1.runasp.net/Uploads/${image.imageUrl}",
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
                                ),
                              )
                            : const Icon(Icons.image_not_supported, size: 60),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: BlocListener<AppCubit, AppStates>(
                          listener: (context, state) {},
                          child: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.white, size: 20),
                            onPressed: () {
                              if (image.imageId != null) {
                                setState(() {
                                  deletedImageIds.add(image.imageId!);
                                });

                                final cubit = AppCubit.get(context);
                                if (!cubit.productImagesToDelete
                                    .contains(image.imageId)) {
                                  cubit.productImagesToDelete
                                      .add(image.imageId!);
                                }
                                AppCubit.get(context).emit(AppUpdateState());
                                debugPrint(
                                    "Deleted image ID: ${image.imageId} — Total deleted: $deletedImageIds");
                              }
                            },
                          ),
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

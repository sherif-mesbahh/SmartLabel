import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_banner_details_page.dart';

class AdminBannersCustomSliderWidget extends StatelessWidget {
  final AppCubit cubit;

  const AdminBannersCustomSliderWidget({
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
                  builder: (context) => Center(
                    child: Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    ),
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
                    AdminBannerDetailsPage(
                      cubit: cubit,
                      bannerId: banner.id!,
                    ),
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
                    ),
                  ),

                  // 🔴 Positioned Delete Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return BlocBuilder<AppCubit, AppStates>(
                              builder: (context, state) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text(
                                      'Are you sure you want to delete this Banner?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: state
                                              is DeleteBannerLoadingState
                                          ? null
                                          : () {
                                              cubit
                                                  .deleteBanner(id: banner.id!)
                                                  .then((_) {
                                                Navigator.of(context).pop();
                                              });
                                            },
                                      child: state is DeleteBannerLoadingState
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Lottie.asset(
                                                'assets/lottie/loading_indicator.json',
                                                width: 100,
                                                height: 100,
                                              ),
                                            )
                                          : const Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
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

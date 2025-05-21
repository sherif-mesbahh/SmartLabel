import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
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
        viewportFraction: 0.85,
        aspectRatio: 2.0,
        enableInfiniteScroll: false,
      ),
      items: banners.map((banner) {
        return InkWell(
          onTap: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );

            await AppCubit.get(context).getBannerDetails(id: banner.id ?? 1);
            if (context.mounted) Navigator.of(context).pop();

            if (context.mounted) {
              pushNavigator(
                context,
                AdminBannerDetailsPage(cubit: cubit, bannerId: banner.id!),
                slideRightToLeft,
              );
            }
          },
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: Uri.encodeFull(
                        'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(banner.mainImage ?? '')}'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: screenHeight(context) * 0.25,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.grey.shade300,
                        width: double.infinity,
                        height: screenHeight(context) * 0.25,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      width: double.infinity,
                      height: screenHeight(context) * 0.25,
                      child: const Center(
                        child: Icon(Icons.broken_image,
                            size: 32, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),

              // 🗑️ Delete Button
              Positioned(
                top: 4,
                right: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Octicons.trash, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocBuilder<AppCubit, AppStates>(
                            builder: (context, state) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: Text(
                                  S.of(context).bannerConfirmDeletion,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  S
                                      .of(context)
                                      .areYouSureYouWantToDeleteThisBanner,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                        S.of(context).bannerDeleteCancelButton),
                                  ),
                                  TextButton(
                                    onPressed: state is DeleteBannerLoadingState
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
                                            ),
                                          )
                                        : Text(
                                            S
                                                .of(context)
                                                .bannerDeleteDeleteButton,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

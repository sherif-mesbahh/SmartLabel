import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/active_banner_details/active_banner_details_app_bar.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/active_banner_details/active_banner_details_image_slider.dart';

class ActiveBannerDetailsPage extends StatelessWidget {
  const ActiveBannerDetailsPage({super.key, required this.id});
  final int id;

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ActiveBannerDetailsAppBar(),
      body: BlocBuilder<AppCubit, AppStates>(
        buildWhen: (previous, current) =>
            current is GetActiveBannerDetailsSuccessState,
        builder: (context, state) {
          final banner = cubit.activeBannerDetailsModel?.data;
          final List<String> bannerImages = banner?.images
                  ?.map((img) => img.imageUrl ?? '')
                  .where((url) => url.isNotEmpty)
                  .toList() ??
              [];

          if (banner == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/failed_icon.png',
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).failedToLoadBannerDetails,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: bannerImages.isNotEmpty
                      ? ActiveBannerDetailsImageSlider(
                          bannerImages: bannerImages)
                      : Container(
                          height: screenHeight(context) * .3,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 48),
                          ),
                        ),
                ),
                const SizedBox(height: 20),

                // Info Card
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoItem(
                            context,
                            title: S.of(context).bannerDetailsTitle,
                            value: banner.title ?? "No title provided",
                          ),
                          _infoItem(
                            context,
                            title: S.of(context).bannerDetailsStartDate,
                            value: _formatDate(banner.startDate),
                          ),
                          _infoItem(
                            context,
                            title: S.of(context).bannerDetailsEndDate,
                            value: _formatDate(banner.endDate),
                          ),
                          _infoItem(
                            context,
                            title: S.of(context).bannerDetailsDescription,
                            value: (banner.description?.trim().isEmpty ?? true)
                                ? "No description provided"
                                : banner.description!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoItem(BuildContext context,
      {required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.productTitle(context)),
          const SizedBox(height: 4),
          Text(value, style: TextStyles.description(context)),
        ],
      ),
    );
  }
}

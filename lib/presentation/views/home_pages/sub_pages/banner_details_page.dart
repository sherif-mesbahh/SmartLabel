import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/active_banner_details/active_banner_details_app_bar.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/active_banner_details/active_banner_details_image_slider.dart';

class BannerDetailsPage extends StatelessWidget {
  const BannerDetailsPage({super.key, required this.id});
  final int id;

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('dd MMM yyyy').format(date);
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
            return  Center(
              child: Text(
                S.of(context).failedToLoadBannerDetails,
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (bannerImages.isNotEmpty)
                  ActiveBannerDetailsImageSlider(bannerImages: bannerImages),
                const SizedBox(height: 16.0),
                Text(S.of(context).bannerDetailsTitle, style: TextStyles.productTitle(context)),
                Text(banner.title ?? "No title provided",
                    style: TextStyles.description(context)),
                const SizedBox(height: 12.0),
                Text(S.of(context).bannerDetailsStartDate, style: TextStyles.productTitle(context)),
                Text(_formatDate(banner.startDate),
                    style: TextStyles.description(context)),
                const SizedBox(height: 12.0),
                Text(S.of(context).bannerDetailsEndDate, style: TextStyles.productTitle(context)),
                Text(_formatDate(banner.endDate),
                    style: TextStyles.description(context)),
                const SizedBox(height: 12.0),
                Text(S.of(context).bannerDetailsDescription, style: TextStyles.productTitle(context)),
                Text(
                  banner.description?.toString().trim().isEmpty == true
                      ? "No description provided"
                      : banner.description.toString(),
                  style: TextStyles.description(context),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          );
        },
      ),
    );
  }
}

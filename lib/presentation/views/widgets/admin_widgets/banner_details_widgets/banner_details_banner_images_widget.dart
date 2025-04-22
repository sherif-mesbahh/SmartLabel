import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_image_model.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/admin_banner_details_images_slider_widget.dart';

class BannerDetailsBannerImaegsWidget extends StatelessWidget {
  const BannerDetailsBannerImaegsWidget({
    super.key,
    required this.banner,
    required this.bannerImages,
  });

  final BannerDetailsDataModel? banner;
  final List<BannerDatailsDataImageModel> bannerImages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminBannerDetailsImagesSliderWidget(
          bannerImages: bannerImages,
        ),
      ],
    );
  }
}

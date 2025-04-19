import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_image_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/active_banner_details/active_banner_details_app_bar.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/add_banner_details_images_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/admin_banner_details_images_slider_widget.dart';

class AdminBannerDetailsPage extends StatelessWidget {
  const AdminBannerDetailsPage({super.key, required this.id});
  final int id;

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);

    return Scaffold(
      appBar: ActiveBannerDetailsAppBar(),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is DeleteBannerDetailsImageSuccessState) {
            Fluttertoast.showToast(
              msg: 'Image deleted successfully.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            cubit.getBannerDetails(id: id);
          }
          if (state is DeleteBannerDetailsImageErrorState) {
            Fluttertoast.showToast(
              msg: 'Error deleting image.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          if (state is AddBannerDetailsImagesSuccessState) {
            Fluttertoast.showToast(
              msg: 'Images added successfully.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          if (state is AddBannerDetailsImagesErrorState) {
            Fluttertoast.showToast(
              msg: 'Error adding images.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          final banner = cubit.bannerDetailsModel?.data;
          final List<BannerDatailsDataImageModel> bannerImages = banner?.images
                  ?.where(
                      (img) => img.imageUrl != null && img.imageUrl!.isNotEmpty)
                  .toList() ??
              [];

          if (banner == null) {
            return const Center(
              child: Text(
                "No banner details available.",
                style: TextStyle(color: Colors.grey),
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
                  Column(
                    children: [
                      AdminBannerDetailsImagesSliderWidget(
                        banner: banner,
                        bannerImages: bannerImages,
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Add Images',
                        style: TextStyles.productTitle
                            .copyWith(color: primaryColor),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AddBannerDetailsImagesDialogWidget(
                            bannerId: id,
                            bannerDetailsDataModel:
                                cubit.bannerDetailsModel!.data!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Title:", style: TextStyles.productTitle),
                    IconButton(
                      icon:
                          const Icon(Icons.edit, size: 20, color: primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
                Text(banner.title ?? "No title provided",
                    style: TextStyles.description),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Start Date:", style: TextStyles.productTitle),
                    IconButton(
                      icon:
                          const Icon(Icons.edit, size: 20, color: primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
                Text(_formatDate(banner.startDate),
                    style: TextStyles.description),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("End Date:", style: TextStyles.productTitle),
                    IconButton(
                      icon:
                          const Icon(Icons.edit, size: 20, color: primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
                Text(_formatDate(banner.endDate),
                    style: TextStyles.description),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Description:", style: TextStyles.productTitle),
                    IconButton(
                      icon:
                          const Icon(Icons.edit, size: 20, color: primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
                Text(
                  banner.description?.toString().trim().isEmpty == true
                      ? "No description provided"
                      : banner.description.toString(),
                  style: TextStyles.description,
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

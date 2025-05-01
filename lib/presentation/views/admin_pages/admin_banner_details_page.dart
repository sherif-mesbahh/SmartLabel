import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_image_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_add_images_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_appBar_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_banner_images_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_description_text_field.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_end_date_text_field.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_main_image_row_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_save_and_discard_buttons_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_start_date_text_field.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/banner_details_title_text_field.dart';

class AdminBannerDetailsPage extends StatefulWidget {
  const AdminBannerDetailsPage(
      {super.key, required this.cubit, required this.bannerId});
  final AppCubit cubit;
  final int bannerId;

  @override
  State<AdminBannerDetailsPage> createState() => _AdminBannerDetailsPageState();
}

class _AdminBannerDetailsPageState extends State<AdminBannerDetailsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  bool hasTextFieldChanged = false;

  @override
  void initState() {
    super.initState();
    final banner = widget.cubit.bannerDetailsModel?.data;

    if (banner != null) {
      titleController.text = banner.title ?? "";
      descController.text = banner.description ?? "";
      startDateController.text = banner.startDate != null
          ? DateFormat('dd MMM yyyy').format(banner.startDate!)
          : "";
      endDateController.text = banner.endDate != null
          ? DateFormat('dd MMM yyyy').format(banner.endDate!)
          : "";
    }
    titleController.addListener(_onTextChanged);
    startDateController.addListener(_onTextChanged);
    endDateController.addListener(_onTextChanged);
    descController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      hasTextFieldChanged = true;
    });
  }

  @override
  void dispose() {
    titleController.removeListener(_onTextChanged);
    startDateController.removeListener(_onTextChanged);
    endDateController.removeListener(_onTextChanged);
    descController.removeListener(_onTextChanged);
    titleController.dispose();
    descController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AdminBannerDetailsAppBarWidget(cubit: cubit),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is UpdateBannerSuccessState) {
            Fluttertoast.showToast(
              msg: 'Banner Updated Successfully',
              backgroundColor: Colors.green,
              textColor: secondaryColor,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 1,
              fontSize: 16,
            );
            cubit.getBanners().then((onValue) {
              cubit.bannerDetailsImagesToUpload = [];
              cubit.bannerDetailsImagesToDelete = [];
              cubit.mainBannerImageToUpload = null;
              popNavigator(context);
            });
          }
          if (state is UpdateBannerErrorState) {
            Fluttertoast.showToast(
              msg: state.error,
              backgroundColor: Colors.red,
              textColor: secondaryColor,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 1,
              fontSize: 16,
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
                "Failed to load banner details",
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main image
                BannerDetailsMainImageRowWidget(cubit: cubit, banner: banner),
                const SizedBox(height: 12),
                // Banner images
                if (bannerImages.isNotEmpty)
                  BannerDetailsBannerImaegsWidget(
                      banner: banner, bannerImages: bannerImages),
                // Add images
                BannerDetailsAddImagesWidget(cubit: cubit, banner: banner),

                const SizedBox(height: 12.0),
                // Title
                BannerDetailsTitleTextField(titleController: titleController),
                const SizedBox(height: 12.0),
                // Start Date
                BannerDetailsStartDateTextField(
                    startDateController: startDateController),
                const SizedBox(height: 12.0),
                // End Date
                BannerDetailsEndDateTextField(
                    endDateController: endDateController),
                const SizedBox(height: 12.0),
                // Description
                BannerDetailsDescriptionTextField(
                    descController: descController),
                if (hasTextFieldChanged ||
                    cubit.bannerDetailsImagesToUpload.isNotEmpty ||
                    cubit.bannerDetailsImagesToDelete.isNotEmpty ||
                    cubit.mainBannerImageToUpload != null)
                  BannerDetailsSaveAndDiscardButtonsWidget(
                    cubit: cubit,
                    widget: widget,
                    titleController: titleController,
                    descController: descController,
                    startDateController: startDateController,
                    endDateController: endDateController,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_banner_details_page.dart';

class BannerDetailsSaveAndDiscardButtonsWidget extends StatelessWidget {
  const BannerDetailsSaveAndDiscardButtonsWidget({
    super.key,
    required this.cubit,
    required this.widget,
    required this.titleController,
    required this.descController,
    required this.startDateController,
    required this.endDateController,
  });

  final AppCubit cubit;
  final AdminBannerDetailsPage widget;
  final TextEditingController titleController;
  final TextEditingController descController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8.0,
      ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Save Changes
              state is UpdateBannerLoadingState
                  ? Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    )
                  : InkWell(
                      child: Text(
                        'Save changes',
                        style: TextStyles.productTitle
                            (context).copyWith(color: primaryColor),
                      ),
                      onTap: () {
                        cubit
                            .updateBanner(
                          id: widget.bannerId,
                          title: titleController.text,
                          description: descController.text,
                          startDate: startDateController.text,
                          endDate: endDateController.text,
                          mainImage: cubit.mainBannerImageToUpload,
                          imageFiles: cubit.bannerDetailsImagesToUpload,
                          imagesToDelete: cubit.bannerDetailsImagesToDelete,
                        )
                            .then((_) {
                          cubit.getBannerDetails(id: widget.bannerId);
                        });
                      },
                    ),
              // Discard
              InkWell(
                child: Text(
                  'Discard',
                  style: TextStyles.productTitle(context).copyWith(color: primaryColor),
                ),
                onTap: () {
                  cubit.bannerDetailsImagesToUpload = [];
                  cubit.bannerDetailsImagesToDelete = [];
                  cubit.mainBannerImageToUpload = null;
                  popNavigator(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

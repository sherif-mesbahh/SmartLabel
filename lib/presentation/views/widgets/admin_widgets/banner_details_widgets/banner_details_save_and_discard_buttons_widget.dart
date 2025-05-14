import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
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
                        S.of(context).editBannerSaveButton,
                        style: TextStyles.productTitle(context)
                            .copyWith(color: primaryColor),
                      ),
                      onTap: () {
                        print(startDateController.text);
                        print(endDateController.text);
                        String fixedStart =
                            normalizeArabicDateToUtc(startDateController.text);
                        String fixedEnd =
                            normalizeArabicDateToUtc(endDateController.text);
                        final parsedStartDate =
                            DateTime.tryParse(fixedStart)?.toLocal();

                        if (parsedStartDate == null) {
                          Fluttertoast.showToast(
                            msg: "Invalid start date format",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                          return;
                        }

                        final nowLocal = DateTime.now(); // local time
                        print(nowLocal);

                        print(fixedStart);
                        print(fixedEnd);
                        cubit
                            .updateBanner(
                          id: widget.bannerId,
                          title: titleController.text,
                          description: descController.text,
                          startDate: fixedStart,
                          endDate: fixedEnd,
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
                  S.of(context).editBannerDiscardButton,
                  style: TextStyles.productTitle(context)
                      .copyWith(color: primaryColor),
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

  String normalizeArabicDateToUtc(String input) {
    // Convert Arabic numerals to English
    const arabicToEnglishDigits = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    String englishDate = input.split('').map((char) {
      return arabicToEnglishDigits[char] ?? char;
    }).join();

    // Parse, add one hour, and return formatted string
    final parsed = DateTime.parse(englishDate);
    final updated = parsed.add(Duration(hours: 0));
    return updated.toUtc().toIso8601String();
  }
}

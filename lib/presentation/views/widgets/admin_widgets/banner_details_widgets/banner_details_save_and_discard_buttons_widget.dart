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
    required this.formKey,
  });

  final AppCubit cubit;
  final AdminBannerDetailsPage widget;
  final TextEditingController titleController;
  final TextEditingController descController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final GlobalKey<FormState> formKey;

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
              state is UpdateBannerLoadingState
                  ? Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    )
                  : TextButton(
                      onPressed: () {
                        print(startDateController.text);
                        print(endDateController.text);

                        String fixedStart =
                            normalizeArabicDateToUtc(startDateController.text);
                        String fixedEnd =
                            normalizeArabicDateToUtc(endDateController.text);

                        final parsedStartDate =
                            DateTime.tryParse(fixedStart)?.toLocal();
                        final parsedEndDate =
                            DateTime.tryParse(fixedEnd)?.toLocal();

                        if (parsedStartDate == null) {
                          Fluttertoast.showToast(
                            msg: "Invalid start date format",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                          return;
                        }

                        if (!parsedStartDate.isBefore(parsedEndDate!)) {
                          Fluttertoast.showToast(
                            msg: S
                                .of(context)
                                .bannerStartDateMustBeBeforeEndDate,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                          return;
                        }

                        if (formKey.currentState!.validate()) {
                          cubit
                              .updateBanner(
                                id: widget.bannerId,
                                title: titleController.text,
                                description: descController.text,
                                startDate: fixedStart,
                                endDate: fixedEnd,
                                mainImage: cubit.mainBannerImageToUpload,
                                imageFiles: cubit.bannerDetailsImagesToUpload,
                                imagesToDelete:
                                    cubit.bannerDetailsImagesToDelete,
                              )
                              .then((_) =>
                                  cubit.getBannerDetails(id: widget.bannerId));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            primaryColor.withOpacity(0.25)),
                        foregroundColor: WidgetStateProperty.all(primaryColor),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                                color: primaryColor.withOpacity(0.4)),
                          ),
                        ),
                        overlayColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed)) {
                              return primaryColor.withOpacity(0.2);
                            }
                            if (states.contains(WidgetState.hovered)) {
                              return primaryColor.withOpacity(0.15);
                            }
                            return null;
                          },
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyles.productTitle(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      child: Text(S.of(context).editBannerSaveButton),
                    ),
              // Discard
              TextButton(
                onPressed: () {
                  cubit.bannerDetailsImagesToUpload = [];
                  cubit.bannerDetailsImagesToDelete = [];
                  cubit.mainBannerImageToUpload = null;
                  popNavigator(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.red.withOpacity(0.25)),
                  foregroundColor: WidgetStateProperty.all(Colors.red),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.red.withOpacity(0.4)),
                    ),
                  ),
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.red.withOpacity(0.2);
                      }
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.red.withOpacity(0.15);
                      }
                      return null;
                    },
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyles.productTitle(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                child: Text(S.of(context).editBannerDiscardButton),
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

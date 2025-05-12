import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AddBannersDialogWidget extends StatefulWidget {
  const AddBannersDialogWidget({super.key});

  @override
  State<AddBannersDialogWidget> createState() => _AddBannersDialogWidgetState();
}

class _AddBannersDialogWidgetState extends State<AddBannersDialogWidget> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  File? mainImage;
  List<XFile> bannerImages = [];

  final picker = ImagePicker();

  Future<void> pickStartDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        final DateTime combined = DateTime(
          date.year,
          date.month,
          date.day,
          time.hourOfPeriod + (time.period == DayPeriod.pm ? 12 : 0),
          time.minute,
        );

        setState(() {
          startDate = combined;
        });
      }
    }
  }

  Future<void> pickEndDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        final DateTime combined = DateTime(
          date.year,
          date.month,
          date.day,
          time.hourOfPeriod + (time.period == DayPeriod.pm ? 12 : 0),
          time.minute,
        );

        setState(() {
          endDate = combined;
        });
      }
    }
  }

  Future<void> pickMainImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => mainImage = File(picked.path));
  }

  Future<void> pickBannerImages() async {
    final pickedList = await picker.pickMultiImage();
    if (pickedList.isNotEmpty) {
      setState(() => bannerImages = pickedList);
    }
  }

  String formatDateTimeForRequest(DateTime? date) {
    return date != null
        ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", 'en').format(date)
        : S.of(context).addBannerDialogBannerSelectDate;
  }

  String formatDateTimeForDisplay(DateTime? date) {
    return date != null
        ? DateFormat.yMMMd().add_jm().format(date)
        : S.of(context).addBannerDialogBannerSelectDate;
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(S.of(context).addBannerDialogTitle,
              style: TextStyles.headline2(context)),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8),
                // Title
                TextField(
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: S.of(context).addBannerDialogBannerTitle,
                    labelStyle: TextStyles.smallText(context),
                    hintStyle: TextStyles.smallText(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: greyColor),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Description
                TextField(
                  keyboardType: TextInputType.text,
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: S.of(context).addBannerDialogBannerDescription,
                    labelStyle: TextStyles.smallText(context),
                    hintStyle: TextStyles.smallText(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: greyColor),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Dates
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).addBannerDialogBannerStartDate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: pickStartDate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            child: Text(
                              formatDateTimeForDisplay(startDate),
                              style: TextStyles.buttonText(context).copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).addBannerDialogBannerEndDate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: pickEndDate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            child: Text(
                              formatDateTimeForDisplay(endDate),
                              style: TextStyles.buttonText(context).copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Main Image
                ElevatedButton(
                  onPressed: pickMainImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    S.of(context).addBannerDialogBannerPickMainImage,
                    style: TextStyles.buttonText(context).copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
                if (mainImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.file(mainImage!, height: 100),
                  ),
                // Banner Images
                ElevatedButton(
                  onPressed: pickBannerImages,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    S.of(context).addBannerDialogBannerPickBannerImages,
                    style: TextStyles.buttonText(context).copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
                if (bannerImages.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: bannerImages
                        .map((img) => Image.file(File(img.path), height: 50))
                        .toList(),
                  ),
              ],
            ),
          ),
          actions: [
            // Cancel
            TextButton(
              child: Text(S.of(context).addBannerDialogBannerCancel,
                  style: TextStyles.productTitle(context)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // Apply
            BlocListener<AppCubit, AppStates>(
              listener: (context, state) {
                if (state is AddBannerSuccessState) {
                  Fluttertoast.showToast(
                    msg: S.of(context).bannerAddedSuccessfuly,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  Navigator.of(context).pop();
                  AppCubit.get(context).getBanners();
                } else if (state is AddBannerErrorState) {
                  Fluttertoast.showToast(
                    msg: S.of(context).errorAddingBanner,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: state is AddBannerLoadingState
                  ? Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    )
                  : TextButton(
                      child: Text(S.of(context).addBannerDialogBannerApply,
                          style: TextStyles.productTitle(context)),
                      onPressed: () {
                        // 1. Validate title
                        if (titleController.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: S.of(context).bannerTitleValidation,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        // 2. Validate dates
                        if (startDate == null || endDate == null) {
                          Fluttertoast.showToast(
                            msg: S.of(context).bannerStartAndEndDateValidation,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        if (!startDate!.isBefore(endDate!)) {
                          Fluttertoast.showToast(
                            msg: S
                                .of(context)
                                .bannerStartDateMustBeBeforeEndDate,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        // 3. Validate main image
                        if (mainImage == null) {
                          Fluttertoast.showToast(
                            msg: S.of(context).bannerMainImageValidation,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        if (bannerImages.isEmpty) {
                          Fluttertoast.showToast(
                            msg: S.of(context).bannerBannerImagesValidation,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        final formattedStart =
                            formatDateTimeForRequest(startDate);
                        final formattedEnd = formatDateTimeForRequest(endDate);
                        print(formattedStart);
                        AppCubit.get(context).addBanner(
                          title: titleController.text,
                          description: descController.text,
                          startDate: formattedStart,
                          endDate: formattedEnd,
                          mainImage: mainImage!,
                          imageFiles: bannerImages,
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

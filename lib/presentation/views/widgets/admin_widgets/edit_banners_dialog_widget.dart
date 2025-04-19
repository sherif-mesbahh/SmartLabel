import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
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
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => startDate = picked);
  }

  Future<void> pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => endDate = picked);
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
        ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date)
        : 'Select Date';
  }

  String formatDateTimeForDisplay(DateTime? date) {
    return date != null
        ? DateFormat.yMMMd().add_jm().format(date)
        : 'Select Date';
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Add Banner', style: TextStyles.headline2),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyles.smallText,
                hintStyle: TextStyles.smallText,
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
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyles.smallText,
                hintStyle: TextStyles.smallText,
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date:',
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
                          style: TextStyles.buttonText.copyWith(
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
                        'End Date:',
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
                          style: TextStyles.buttonText.copyWith(
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
            ElevatedButton(
              onPressed: pickMainImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Pick Main Image",
                style: TextStyles.buttonText.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
            if (mainImage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.file(mainImage!, height: 100),
              ),
            ElevatedButton(
              onPressed: pickBannerImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Pick Banner Images",
                style: TextStyles.buttonText.copyWith(
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
        TextButton(
          child: Text('Cancel', style: TextStyles.productTitle),
          onPressed: () {
            AppCubit.get(context).getBanners();
            Navigator.of(context).pop();
          },
        ),
        BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return TextButton(
              child: Text('Apply', style: TextStyles.productTitle),
              onPressed: () {
                if (titleController.text.isEmpty ||
                    descController.text.isEmpty ||
                    startDate == null ||
                    endDate == null ||
                    mainImage == null ||
                    bannerImages.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please fill in all fields and select images.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  return;
                }
                final formattedStart = formatDateTimeForRequest(startDate);
                final formattedEnd = formatDateTimeForRequest(endDate);
                AppCubit.get(context)
                    .addBanner(
                  title: titleController.text,
                  description: descController.text,
                  startDate: formattedStart,
                  endDate: formattedEnd,
                  mainImage: mainImage!,
                  imageFiles: bannerImages,
                )
                    .then((onValue) {
                  AppCubit.get(context).getBanners();
                  Navigator.of(context).pop();
                });
              },
            );
          },
        ),
      ],
    );
  }
}

// SizedBox(
//               height: screenHeight(context) * .2,
//               child: ListView.separated(
//                 physics: BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 separatorBuilder: (context, index) => const SizedBox(width: 10),
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     alignment: Alignment.topRight,
//                     children: [
//                       Image(
//                         height: screenHeight(context) * .2,
//                         width: screenWidth(context) * .4,
//                         image: AssetImage(
//                           'assets/images/offer_image.jpg',
//                         ),
//                       ),
//                       Positioned(
//                         top: -10,
//                         right: -5,
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//                 itemCount: 10,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               'Add New Banners',
//               style: TextStyles.headline2,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Image(
//                   height: screenHeight(context) * .2,
//                   width: screenWidth(context) * .3,
//                   image: AssetImage(
//                     'assets/images/offer_image.jpg',
//                   ),
//                 ),
//                 Spacer(),
//                 TextButton(
//                   child: Text(
//                     'Add Banner',
//                     style:
//                         TextStyles.productTitle.copyWith(color: primaryColor),
//                   ),
//                   onPressed: () {},
//                 ),
//               ],
//             ),

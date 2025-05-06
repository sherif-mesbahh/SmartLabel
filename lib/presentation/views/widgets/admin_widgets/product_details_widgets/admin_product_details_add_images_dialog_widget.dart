import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/product_details_model/product_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AddProductDetailsImagesDialogWidget extends StatefulWidget {
  final int productId;
  final ProductDetailsDataModel productDetailsDataModel;
  const AddProductDetailsImagesDialogWidget({
    super.key,
    required this.productId,
    required this.productDetailsDataModel,
  });

  @override
  State<AddProductDetailsImagesDialogWidget> createState() =>
      _AddProductsDialogWidgetState();
}

class _AddProductsDialogWidgetState
    extends State<AddProductDetailsImagesDialogWidget> {
  List<XFile> productDetailsImages = [];

  final picker = ImagePicker();

  Future<void> pickProductDetailsImages() async {
    final pickedList = await picker.pickMultiImage();
    if (pickedList.isNotEmpty) {
      setState(() => productDetailsImages = pickedList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text('Add Product Images', style: TextStyles.headline2(context)),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: pickProductDetailsImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Pick Product Images",
                style: TextStyles.buttonText(context).copyWith(
                  fontSize: 12,
                ),
              ),
            ),
            if (productDetailsImages.isNotEmpty)
              Wrap(
                spacing: 8,
                children: productDetailsImages
                    .map((img) => Image.file(File(img.path), height: 50))
                    .toList(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyles.productTitle(context)),
          onPressed: () {
            AppCubit.get(context).getProductDetails(
              id: widget.productId,
            );
            Navigator.of(context).pop();
          },
        ),
        BlocListener<AppCubit, AppStates>(
          listener: (context, state) {},
          child: TextButton(
            child: Text('Apply', style: TextStyles.productTitle(context)),
            onPressed: () {
              AppCubit.get(context)
                  .productImagesToUpload
                  .addAll(productDetailsImages);

              productDetailsImages.clear();

              AppCubit.get(context).emit(AppUpdateState());

              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}

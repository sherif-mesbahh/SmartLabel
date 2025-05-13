import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/category_products_model/category_products_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class EditCategoryImageDialog extends StatefulWidget {
  final int categoryId;
  final CategoryProductsDataModel categoryProductsDataModel;

  const EditCategoryImageDialog(
      {super.key,
      required this.categoryId,
      required this.categoryProductsDataModel});

  @override
  State<EditCategoryImageDialog> createState() =>
      _AddMainBannerImageDialogWidgetState();
}

class _AddMainBannerImageDialogWidgetState
    extends State<EditCategoryImageDialog> {
  XFile? categoryImage;
  final picker = ImagePicker();

  Future<void> pickCategoryImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => categoryImage = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(S.of(context).setNewCategoryImage,
          style: TextStyles.headline2(context)),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: pickCategoryImage,
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: Text(
                S.of(context).pickNewCategoryImage,
                style: TextStyles.buttonText(context).copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(height: 12),
            if (categoryImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(categoryImage!.path),
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).pickNewCategoryImageCancel,
              style: TextStyles.productTitle(context)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocListener<AppCubit, AppStates>(
          listener: (context, state) {},
          child: TextButton(
            child: Text(S.of(context).pickNewCategoryImageApply,
                style: TextStyles.productTitle(context)),
            onPressed: () {
              if (categoryImage != null) {
                AppCubit.get(context).mainCategoryImageToUpload = categoryImage;
                AppCubit.get(context).emit(AppUpdateState());
              }
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}

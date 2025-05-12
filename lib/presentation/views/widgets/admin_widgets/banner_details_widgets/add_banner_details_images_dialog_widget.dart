import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AddBannerDetailsImagesDialogWidget extends StatefulWidget {
  final int bannerId;
  final BannerDetailsDataModel bannerDetailsDataModel;
  const AddBannerDetailsImagesDialogWidget({
    super.key,
    required this.bannerId,
    required this.bannerDetailsDataModel,
  });

  @override
  State<AddBannerDetailsImagesDialogWidget> createState() =>
      _AddBannersDialogWidgetState();
}

class _AddBannersDialogWidgetState
    extends State<AddBannerDetailsImagesDialogWidget> {
  List<XFile> bannerDetailsImages = [];

  final picker = ImagePicker();

  Future<void> pickBannerDetailsImages() async {
    final pickedList = await picker.pickMultiImage();
    if (pickedList.isNotEmpty) {
      setState(() => bannerDetailsImages = pickedList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(S.of(context).editBannerAddImagesDialogTitle,
          style: TextStyles.headline2(context)),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: pickBannerDetailsImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                S.of(context).editBannerAddImagesDialogPickBannreImages,
                style: TextStyles.buttonText(context).copyWith(
                  fontSize: 12,
                ),
              ),
            ),
            if (bannerDetailsImages.isNotEmpty)
              Wrap(
                spacing: 8,
                children: bannerDetailsImages
                    .map((img) => Image.file(File(img.path), height: 50))
                    .toList(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).editBannerAddImagesDialogCancelButton,
              style: TextStyles.productTitle(context)),
          onPressed: () {
            AppCubit.get(context).getBannerDetails(
              id: widget.bannerId,
            );
            Navigator.of(context).pop();
          },
        ),
        BlocListener<AppCubit, AppStates>(
          listener: (context, state) {},
          child: TextButton(
            child: Text(S.of(context).editBannerAddImagesDialogApplyButton,
                style: TextStyles.productTitle(context)),
            onPressed: () {
              AppCubit.get(context)
                  .bannerDetailsImagesToUpload
                  .addAll(bannerDetailsImages);

              bannerDetailsImages.clear();

              AppCubit.get(context).emit(AppUpdateState());

              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}

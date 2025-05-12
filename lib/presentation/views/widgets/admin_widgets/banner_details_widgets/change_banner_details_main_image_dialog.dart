import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AddMainBannerImageDialogWidget extends StatefulWidget {
  const AddMainBannerImageDialogWidget({
    super.key,
  });

  @override
  State<AddMainBannerImageDialogWidget> createState() =>
      _AddMainBannerImageDialogWidgetState();
}

class _AddMainBannerImageDialogWidgetState
    extends State<AddMainBannerImageDialogWidget> {
  XFile? mainImage;
  final picker = ImagePicker();

  Future<void> pickMainImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => mainImage = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title:
          Text(S.of(context).setMainBannerImage, style: TextStyles.headline2(context)),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: pickMainImage,
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: Text(
                S.of(context).editBannerDialogPickMainImage,
                style: TextStyles.buttonText(context).copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(height: 12),
            if (mainImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(mainImage!.path),
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).cancelButton, style: TextStyles.productTitle(context)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocListener<AppCubit, AppStates>(
          listener: (context, state) {},
          child: TextButton(
            child: Text(S.of(context).editBannerDialogApplyButton, style: TextStyles.productTitle(context)),
            onPressed: () {
              if (mainImage != null) {
                AppCubit.get(context).mainBannerImageToUpload = mainImage;
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

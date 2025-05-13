import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AddNewCategoryDialog extends StatefulWidget {
  const AddNewCategoryDialog({super.key});

  @override
  State<AddNewCategoryDialog> createState() => _AddCategoryDialogWidgetState();
}

class _AddCategoryDialogWidgetState extends State<AddNewCategoryDialog> {
  final nameController = TextEditingController();
  final picker = ImagePicker();
  File? categoryImage;

  Future<void> pickCategoryImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => categoryImage = File(picked.path));
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddCategorySuccessState) {
          Fluttertoast.showToast(
            msg: S.of(context).categoryAddedSuccessfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).pop();
          AppCubit.get(context).getCategories();
        } else if (state is AddCategoryErrorState) {
          Fluttertoast.showToast(
            msg: S.of(context).categoryFailedToAdd,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(S.of(context).categoryDialogTitle,
              style: TextStyles.headline2(context)),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: S.of(context).categoryDialogCategoryName,
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
                ElevatedButton(
                  onPressed: pickCategoryImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    S.of(context).categoryDialogPickImage,
                    style:
                        TextStyles.buttonText(context).copyWith(fontSize: 12),
                  ),
                ),
                if (categoryImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.file(categoryImage!, height: 100),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(S.of(context).categoryDialogCancelButton,
                  style: TextStyles.productTitle(context)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            state is AddCategoryLoadingState
                ? Lottie.asset(
                    'assets/lottie/loading_indicator.json',
                    width: 100,
                    height: 100,
                  )
                : TextButton(
                    child: Text(S.of(context).categoryDialogApplyButton,
                        style: TextStyles.productTitle(context)),
                    onPressed: () {
                      if (nameController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: S.of(context).categoryDialogNameValidation,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      // 2. Optional: check name length
                      if (nameController.text.length < 3) {
                        Fluttertoast.showToast(
                          msg: S.of(context).categoryDialogNameLengthValidation,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      // 3. Check if image is picked
                      if (categoryImage == null) {
                        Fluttertoast.showToast(
                          msg: S.of(context).categoryDialogImageValidation,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }
                      AppCubit.get(context).addCategory(
                        name: nameController.text,
                        image: categoryImage!,
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}

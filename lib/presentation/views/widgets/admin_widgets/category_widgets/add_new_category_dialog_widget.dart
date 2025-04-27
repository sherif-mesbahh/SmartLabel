import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
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
            msg: "Category added successfully.",
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
            msg: "Failed to add category. Try again.",
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
          backgroundColor: Colors.white,
          title: Text('Add Category', style: TextStyles.headline2),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
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
                ElevatedButton(
                  onPressed: pickCategoryImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    "Pick Category Image",
                    style: TextStyles.buttonText.copyWith(fontSize: 12),
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
              child: Text('Cancel', style: TextStyles.productTitle),
              onPressed: () => Navigator.of(context).pop(),
            ),
            state is AddCategoryLoadingState
                ? Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    )
                : TextButton(
                    child: Text('Apply', style: TextStyles.productTitle),
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          categoryImage == null) {
                        Fluttertoast.showToast(
                          msg: "Please enter name and pick an image.",
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

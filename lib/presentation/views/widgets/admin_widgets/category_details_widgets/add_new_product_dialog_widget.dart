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

class AddProductDialogWidget extends StatefulWidget {
  const AddProductDialogWidget({super.key, required this.categoryId});
  final int categoryId;

  @override
  State<AddProductDialogWidget> createState() => _AddProductDialogWidgetState();
}

class _AddProductDialogWidgetState extends State<AddProductDialogWidget> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final descController = TextEditingController();

  File? mainImage;
  final picker = ImagePicker();
  List<XFile> productImages = [];

  Future<void> pickMainImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => mainImage = File(picked.path));
  }

  Future<void> pickProductImages() async {
    final pickedList = await picker.pickMultiImage();
    if (pickedList.isNotEmpty) {
      setState(() => productImages = pickedList);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    discountController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddProductSuccessState) {
          Fluttertoast.showToast(
            msg: "Product added successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).pop();
          AppCubit.get(context).getCategoryProducts(id: widget.categoryId);
        } else if (state is AddProductErrorState) {
          Fluttertoast.showToast(
            msg: "Failed to add product. Try again.",
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
          title: Text('Add Product', style: TextStyles.headline2(context)),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Name
                  _buildTextField(
                    controller: nameController,
                    label: 'Product Name',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),

                  // Price
                  _buildTextField(
                      controller: priceController,
                      label: 'Price',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 10),

                  // Discount
                  _buildTextField(
                      controller: discountController,
                      label: 'Discount (%)',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 10),

                  // Description
                  _buildTextField(
                    controller: descController,
                    label: 'Description',
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),

                  // Main Image
                  ElevatedButton(
                    onPressed: pickMainImage,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: Text("Pick Image",
                        style: TextStyles.buttonText(context)
                            .copyWith(fontSize: 12)),
                  ),
                  if (mainImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.file(mainImage!, height: 100),
                    ),
                  ElevatedButton(
                    onPressed: pickProductImages,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: Text("Pick Product Images",
                        style: TextStyles.buttonText(context)
                            .copyWith(fontSize: 12)),
                  ),
                  if (productImages.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: productImages
                            .map(
                                (img) => Image.file(File(img.path), height: 50))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyles.productTitle(context)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            state is AddProductLoadingState
                ? Lottie.asset(
                    'assets/lottie/loading_indicator.json',
                    width: 100,
                    height: 100,
                  )
                : TextButton(
                    child: Text('Add', style: TextStyles.productTitle(context)),
                    onPressed: () {
                      // 1. Check if name is empty
                      if (nameController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Product name must not be empty.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      // 2. Check if price is empty or invalid
                      if (priceController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Price must not be empty.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      final price = double.tryParse(priceController.text);
                      if (price == null || price <= 0) {
                        Fluttertoast.showToast(
                          msg: "Price must be a valid positive number.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      // 3. Check if discount is empty or invalid
                      if (discountController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Discount must not be empty.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      final discount = double.tryParse(discountController.text);
                      if (discount == null ||
                          discount % 1 != 0 ||
                          discount < 0 ||
                          discount > 100) {
                        Fluttertoast.showToast(
                          msg:
                              "Discount must be a valid number between 0 and 100.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      // 4. Check if main image is null
                      if (mainImage == null) {
                        Fluttertoast.showToast(
                          msg: "Please select a main image.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      AppCubit.get(context).addProduct(
                        categoryId: widget.categoryId,
                        name: nameController.text,
                        oldPrice: priceController.text,
                        discount: discountController.text,
                        description: descController.text,
                        mainImage: mainImage!,
                        imageFiles: productImages,
                      );
                    },
                  ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
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
    );
  }
}

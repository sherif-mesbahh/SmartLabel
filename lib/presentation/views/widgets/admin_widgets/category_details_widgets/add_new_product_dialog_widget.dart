import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
          backgroundColor: Colors.white,
          title: Text('Add Product', style: TextStyles.headline2),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Name
                  _buildTextField(
                      controller: nameController, label: 'Product Name'),
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
                      maxLines: 3),
                  const SizedBox(height: 10),

                  // Main Image
                  ElevatedButton(
                    onPressed: pickMainImage,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: Text("Pick Image",
                        style: TextStyles.buttonText.copyWith(fontSize: 12)),
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
                        style: TextStyles.buttonText.copyWith(fontSize: 12)),
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
              child: Text('Cancel', style: TextStyles.productTitle),
              onPressed: () => Navigator.of(context).pop(),
            ),
            state is AddProductLoadingState
                ? CircularProgressIndicator(color: primaryColor)
                : TextButton(
                    child: Text('Add', style: TextStyles.productTitle),
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          discountController.text.isEmpty ||
                          descController.text.isEmpty ||
                          mainImage == null ||
                          productImages.isEmpty) {
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

                      final discount = double.tryParse(discountController.text);
                      if (discount == null || discount % 1 != 0) {
                        Fluttertoast.showToast(
                          msg: "Discount must be a whole number (e.g., 10).",
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
    );
  }
}

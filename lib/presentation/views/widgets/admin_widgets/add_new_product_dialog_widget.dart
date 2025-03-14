import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class AddNewProductDialog extends StatelessWidget {
  AddNewProductDialog({
    super.key,
    required this.categoryId,
  });
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add New Product', style: TextStyles.headline2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormFieldWidget(
              controller: productNameController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter Product name';
                }
                return null;
              },
              hintText: 'Product Name',
              labelText: 'Product Name',
              obscureText: false,
              suffixIconOnPressed: () {},
            ),
            SizedBox(height: 10),
            CustomTextFormFieldWidget(
              controller: productNameController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter Product Price';
                }
                return null;
              },
              hintText: 'Product Price',
              labelText: 'Product Price',
              obscureText: false,
              suffixIconOnPressed: () {},
            ),
            SizedBox(height: 10),
            CustomTextFormFieldWidget(
              controller: productNameController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter Product Description';
                }
                return null;
              },
              hintText: 'Product Description',
              labelText: 'Product Description',
              obscureText: false,
              suffixIconOnPressed: () {},
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Add Image',
                    style:
                        TextStyles.productTitle.copyWith(color: primaryColor),
                  ),
                ),
                Spacer(),
                Image(
                  height: screenHeight(context) * .15,
                  width: screenWidth(context) * .15,
                  image: AssetImage(
                    'assets/images/fruits_image.jpg',
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyles.productTitle),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Add', style: TextStyles.productTitle),
            onPressed: () {},
          ),
        ]);
  }
}

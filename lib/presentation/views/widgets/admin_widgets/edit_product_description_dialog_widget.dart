import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class EditProductDescriptionDialogWidget extends StatelessWidget {
  EditProductDescriptionDialogWidget({super.key, required this.productId});
  final TextEditingController productDescriptionController =
      TextEditingController();
  final int productId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Edit Product Description', style: TextStyles.headline2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormFieldWidget(
              controller: productDescriptionController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter Product new Description';
                }
                return null;
              },
              hintText: 'Product new Description',
              labelText: 'Product new Description',
              obscureText: false,
              suffixIconOnPressed: () {},
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
            child: Text('Apply', style: TextStyles.productTitle),
            onPressed: () {},
          ),
        ]);
  }
}

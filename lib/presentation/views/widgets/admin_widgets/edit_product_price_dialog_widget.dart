import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class EditProductPriceDialogWidget extends StatelessWidget {
  EditProductPriceDialogWidget({super.key, required this.productId});
  final TextEditingController productNewPriceController =
      TextEditingController();
  final int productId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Edit Product price', style: TextStyles.headline2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormFieldWidget(
              controller: productNewPriceController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter Product new price';
                }
                return null;
              },
              hintText: 'Product new price',
              labelText: 'Product new price',
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

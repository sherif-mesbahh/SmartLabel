import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class EditProductNameDialogWidget extends StatelessWidget {
  EditProductNameDialogWidget({super.key, required this.productId});
  final TextEditingController productNewNameController =
      TextEditingController();
  final int productId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Edit Product Name', style: TextStyles.headline2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormFieldWidget(
              controller: productNewNameController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter Product new name';
                }
                return null;
              },
              hintText: 'Product new Name',
              labelText: 'Product new Name',
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

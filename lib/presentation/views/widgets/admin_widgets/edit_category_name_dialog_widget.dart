import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class EditCategoryNameDialog extends StatelessWidget {
  EditCategoryNameDialog({super.key, required this.categoryId});
  final TextEditingController categoryNewNameController =
      TextEditingController();
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Edit Category Name', style: TextStyles.headline2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormFieldWidget(
              controller: categoryNewNameController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please enter category new name';
                }
                return null;
              },
              hintText: 'Category new Name',
              labelText: 'Category new Name',
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

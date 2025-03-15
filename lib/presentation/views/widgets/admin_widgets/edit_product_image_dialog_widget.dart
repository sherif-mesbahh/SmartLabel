import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class EditProductImageDialogWidget extends StatelessWidget {
  const EditProductImageDialogWidget({super.key, required this.productId});
  final int productId;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Edit Product Image', style: TextStyles.headline2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit Image',
                    style:
                        TextStyles.productTitle.copyWith(color: primaryColor),
                  ),
                ),
                Spacer(),
                Image(
                  height: screenHeight(context) * .3,
                  width: screenWidth(context) * .3,
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
            child: Text('Apply', style: TextStyles.productTitle),
            onPressed: () {},
          ),
        ]);
  }
}

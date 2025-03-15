import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class EditBannersDialogWidget extends StatelessWidget {
  const EditBannersDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Edit Banners', style: TextStyles.headline2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * .2,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image(
                        height: screenHeight(context) * .2,
                        width: screenWidth(context) * .4,
                        image: AssetImage(
                          'assets/images/offer_image.jpg',
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: -5,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: 10,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Add New Banners',
              style: TextStyles.headline2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image(
                  height: screenHeight(context) * .2,
                  width: screenWidth(context) * .3,
                  image: AssetImage(
                    'assets/images/offer_image.jpg',
                  ),
                ),
                Spacer(),
                TextButton(
                  child: Text(
                    'Add Banner',
                    style:
                        TextStyles.productTitle.copyWith(color: primaryColor),
                  ),
                  onPressed: () {},
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

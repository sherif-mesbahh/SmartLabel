import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class FavListViewItem extends StatelessWidget {
  const FavListViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                height: screenHeight(context) * .15,
                width: screenWidth(context) * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/fruits_image.jpg',
                    ),
                  ),
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Image(
                height: screenHeight(context) * .05,
                width: screenWidth(context) * .09,
                image: AssetImage(
                  'assets/images/discount_image.png',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: TextStyles.productTitle,
                ),
                Text(
                  '100\$',
                  style: TextStyles.productPrice,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '100\$',
                  style: TextStyles.productOldPrice,
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_outlined),
          ),
        ],
      ),
    );
  }
}

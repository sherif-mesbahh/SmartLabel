import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNavigator(context, ProductDetailsPage());
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: screenHeight(context) * .2,
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
              Text(
                'Product Name',
                style: TextStyles.productTitle,
              ),
              Row(
                children: [
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
            ],
          ),
          Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: primaryColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

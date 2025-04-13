import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class CategoryProductsGridViewItem extends StatelessWidget {
  final dynamic model;

  const CategoryProductsGridViewItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNavigator(context, ProductDetailsPage(), slideRightToLeft);
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
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: 'Uploads/${model.imageUrl}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: primaryColor,
                        )),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
                '${model.name}',
                style: TextStyles.productTitle,
              ),
              Row(
                children: [
                  Text(
                    '${model.newPrice}\$',
                    style: TextStyles.productPrice,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${model.oldPrice}\$',
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

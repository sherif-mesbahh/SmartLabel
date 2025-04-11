import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class FavListViewItem extends StatelessWidget {
  final dynamic favModel;

  const FavListViewItem({
    super.key,
    required this.favModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNavigator(context, ProductDetailsPage());
      },
      child: Padding(
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
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: favModel.imageUrl != null &&
                            favModel.imageUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl:
                                'http://smartlabel1.runasp.net/Uploads/${favModel.imageUrl}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.broken_image,
                                size: 40,
                                color: Colors.white),
                          )
                        : const Icon(Icons.broken_image,
                            size: 40, color: Colors.white),
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
                    '${favModel.name}',
                    style: TextStyles.productTitle,
                  ),
                  Text(
                    '${favModel.newPrice}\$',
                    style: TextStyles.productPrice,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${favModel.oldPrice}\$',
                    style: TextStyles.productOldPrice,
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

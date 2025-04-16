import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/fav_model/fav_datum.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class FavListViewItem extends StatelessWidget {
  final FavDatum favModel;
  final AppCubit cubit;
  final int index;

  const FavListViewItem({
    super.key,
    required this.favModel,
    required this.cubit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final product = cubit.favModel?.data?[index];
    final String imageUrl = favModel.mainImage ?? '';
    final bool hasDiscount =
        favModel.oldPrice != null && favModel.oldPrice! > favModel.newPrice!;

    return InkWell(
      onTap: () {
        cubit.getProductDetails(id: product?.id ?? 0).then((onValue) {
          pushNavigator(context, ProductDetailsPage(), slideRightToLeft);
        });
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
                  height: screenHeight(context) * 0.15,
                  width: screenWidth(context) * 0.3,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl:
                                'http://smartlabel1.runasp.net/Uploads/$imageUrl',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.broken_image,
                            size: 40, color: Colors.white),
                  ),
                ),
                if (hasDiscount)
                  Image(
                    height: screenHeight(context) * 0.05,
                    width: screenWidth(context) * 0.09,
                    image: const AssetImage('assets/images/discount_image.png'),
                  ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${favModel.name}',
                      style: TextStyles.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${favModel.newPrice}\$',
                      style: TextStyles.productPrice,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (hasDiscount)
                      Text(
                        '${favModel.oldPrice}\$',
                        style: TextStyles.productOldPrice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
            // 🟥 This section left exactly as you had it
            favModel.favorite!
                ? InkWell(
                    onTap: () {},
                    child: Lottie.asset(
                      'assets/lottie/inFavAnimation.json',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      repeat: false,
                      reverse: false,
                      animate: true,
                    ),
                  )
                : InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Lottie.asset(
                        'assets/lottie/notFavAnimation.json',
                        width: 40,
                        height: 40,
                        repeat: false,
                        reverse: false,
                        animate: true,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

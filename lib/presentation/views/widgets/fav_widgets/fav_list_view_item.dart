import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/fav_model/fav_datum.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class FavCardItem extends StatelessWidget {
  final FavDatum favModel;
  final AppCubit cubit;
  final int index;

  const FavCardItem({
    super.key,
    required this.favModel,
    required this.cubit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = favModel.mainImage ?? '';
    final hasDiscount =
        favModel.oldPrice != null && favModel.oldPrice! > favModel.newPrice!;

    return GestureDetector(
      onTap: () {
        cubit.getProductDetails(id: favModel.id!).then((_) {
          pushNavigator(context, ProductDetailsPage(), slideRightToLeft);
        });
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: 'http://smartlabel1.runasp.net/Uploads/$imageUrl',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: Lottie.asset(
                          'assets/lottie/loading_indicator.json',
                          width: 80),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      if (!AppCubit.get(context).isLogin) {
                        Fluttertoast.showToast(
                          msg: S.of(context).youMustBeLoggedIn,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      } else {
                        favModel.favorite!
                            ? cubit.removeFromFav(model: favModel)
                            : cubit.addToFav(model: favModel);
                      }
                    },
                    child: favModel.favorite!
                        ? Lottie.asset(
                            'assets/lottie/inFavAnimation.json',
                            width: 40,
                            height: 40,
                            repeat: false,
                            fit: BoxFit.fill,
                          )
                        : Lottie.asset(
                            'assets/lottie/notFavAnimation.json',
                            width: 40,
                            height: 40,
                            repeat: false,
                          ),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                favModel.name ?? '',
                style: TextStyles.productTitle(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${favModel.newPrice?.toStringAsFixed(2) ?? ''} \$',
                style: TextStyles.productPrice(context),
              ),
            ),
            if (hasDiscount)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${favModel.oldPrice?.toStringAsFixed(2) ?? ''} \$',
                  style: TextStyles.productOldPrice(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

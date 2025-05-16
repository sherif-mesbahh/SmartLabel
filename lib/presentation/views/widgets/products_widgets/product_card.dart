import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final AppCubit cubit;
  final int index;

  const ProductCard({
    super.key,
    required this.cubit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final product = cubit.productModel?.data?[index];

    if (product == null) {
      return const SizedBox(); // or placeholder
    }

    final isFavorite = product.favorite ?? false;
    final newPrice = product.newPrice ?? 0;
    final oldPrice = product.oldPrice ?? 0;
    final name = product.name ?? 'Unknown product';

    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: Lottie.asset(
                'assets/lottie/loading_indicator.json',
                width: 100,
                height: 100,
              ),
            ),
          );

          await AppCubit.get(context).getProductDetails(id: product.id ?? 0);

          if (context.mounted) {
            Navigator.of(context).pop();
          }

          if (context.mounted) {
            pushNavigator(context, ProductDetailsPage(), slideRightToLeft);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      "http://smartlabel1.runasp.net/Uploads/${product.mainImage}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                ),
                if (newPrice != oldPrice)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/images/discount_image.png',
                      width: 60,
                      height: 60,
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
                        if (isFavorite) {
                          cubit.removeFromFav(model: product);
                        } else {
                          cubit.addToFav(model: product);
                        }
                      }
                    },
                    child: isFavorite
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.productTitle(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      '\$${newPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (newPrice != oldPrice && oldPrice > 0)
                    Flexible(
                      child: Text(
                        '\$${oldPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8), // spacing at bottom
          ],
        ),
      ),
    );
  }
}

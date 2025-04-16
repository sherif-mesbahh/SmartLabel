import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/product_model/product_datum.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class GridViewProductPageItem extends StatelessWidget {
  final ProductDatum model;

  const GridViewProductPageItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: primaryColor),
          ),
        );

        await AppCubit.get(context).getProductDetails(id: model.id!);

        if (context.mounted) {
          Navigator.of(context).pop();
        }

        if (context.mounted) {
          pushNavigator(context, ProductDetailsPage(), slideRightToLeft);
        }
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
                    width: screenWidth(context) * .5,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'http://smartlabel1.runasp.net/Uploads/${model.mainImage}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  if (model.newPrice != model.oldPrice)
                    Image(
                      height: screenHeight(context) * .06,
                      width: screenWidth(context) * .1,
                      image: AssetImage(
                        'assets/images/discount_image.png',
                      ),
                    ),
                ],
              ),
              Text(
                '${model.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                  if (model.newPrice != model.oldPrice)
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
            child: model.favorite!
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
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
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class ListViewSearchProductWidget extends StatelessWidget {
  const ListViewSearchProductWidget({
    super.key,
    required this.cubit,
    required this.index,
  });

  final AppCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppCubit.get(context)
            .getProductDetails(
                id: cubit.productSearchModel!.data![index].id ?? 0)
            .then((onValue) {
          pushNavigator(context, ProductDetailsPage(),slideRightToLeft);
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
                  height: screenHeight(context) * .15,
                  width: screenWidth(context) * .3,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          'http://smartlabel1.runasp.net/Uploads/${cubit.productSearchModel?.data?[index].imageUrl}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                if (cubit.productSearchModel?.data?[index].newPrice !=
                    cubit.productSearchModel?.data?[index].oldPrice)
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
                    '${cubit.productSearchModel?.data?[index].name}',
                    style: TextStyles.productTitle,
                  ),
                  Text(
                    '${cubit.productSearchModel?.data?[index].newPrice}\$',
                    style: TextStyles.productPrice,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (cubit.productSearchModel?.data?[index].newPrice !=
                      cubit.productSearchModel?.data?[index].oldPrice)
                    Text(
                      '${cubit.productSearchModel?.data?[index].oldPrice}\$',
                      style: TextStyles.productOldPrice,
                    ),
                ],
              ),
            ),
            Spacer(),
            cubit.productSearchModel?.data![index].favorite ?? false
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
          ],
        ),
      ),
    );
  }
}

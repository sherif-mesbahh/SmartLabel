import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/product_model/product_datum.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
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
          builder: (context) => Center(
            child: Lottie.asset(
              'assets/lottie/loading_indicator.json',
              width: 100,
              height: 100,
            ),
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
                    height: screenHeight(context) * .15,
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
                          child: Lottie.asset(
                            'assets/lottie/loading_indicator.json',
                            width: 100,
                            height: 100,
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
                style: TextStyles.productTitle(context),
              ),
              Row(
                children: [
                  Text(
                    '${model.newPrice}\$',
                    style: TextStyles.productPrice(context),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (model.newPrice != model.oldPrice)
                    Text(
                      '${model.oldPrice}\$',
                      style: TextStyles.productOldPrice(context),
                    ),
                ],
              ),
            ],
          ),
          BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return Positioned(
                top: -5,
                right: -5,
                child: model.favorite!
                    ? InkWell(
                        onTap: () {
                          if (AppCubit.get(context).isLogin) {
                            AppCubit.get(context).removeFromFav(model: model);
                          } else {
                            Fluttertoast.showToast(
                              msg: 'You must be logged in.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
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
                        onTap: () {
                          if (AppCubit.get(context).isLogin) {
                            AppCubit.get(context).addToFav(
                              model: model,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: 'You must be logged in.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
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
              );
            },
          ),
        ],
      ),
    );
  }
}

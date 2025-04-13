import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class GridViewItem extends StatelessWidget {
  final dynamic model;

  const GridViewItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            AppCubit.get(context)
                .getProductDetails(id: model.id)
                .then((onValue) {
              pushNavigator(context, ProductDetailsPage());
            });
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
                                'http://smartlabel1.runasp.net/Uploads/${model.imageUrl}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
                child: model.favorite
                    ? IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

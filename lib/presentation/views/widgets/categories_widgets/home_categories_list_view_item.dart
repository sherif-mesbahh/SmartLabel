import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/themes/themes.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/category_model/category_datum.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/categories_products_page.dart';

class HomeCategoriesListViewItem extends StatelessWidget {
  final CategoryDatum model;
  const HomeCategoriesListViewItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppCubit.get(context)
            .getCategoryProducts(id: model.id!)
            .then((onValue) {
          pushNavigator(
              context,
              CategoriesProductsPage(
                categoryId: model.id!,
              ),
              slideRightToLeft);
        });
      },
      child: SizedBox(
        width: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    'http://smartlabel1.runasp.net/Uploads/${model.imageUrl}',
                  ),
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Text(
              model.name ?? 'No Name',
              style: TextStyles.productTitle(context),
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
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
        width: screenWidth(context) * .2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight(context) * .08,
              width: screenWidth(context) * .2,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: model.imageUrl != null && model.imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: Uri.encodeFull(
                            'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(model.imageUrl ?? '')}'),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const Icon(Icons.person, color: Colors.white),
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

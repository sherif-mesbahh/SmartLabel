import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/categories_products_page.dart';

class ListViewSearchCategoriesWidget extends StatelessWidget {
  const ListViewSearchCategoriesWidget({
    super.key,
    required this.cubit,
    required this.index,
  });

  final AppCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    final category = cubit.categorySearchModel?.data?[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black26,
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            AppCubit.get(context)
                .getCategoryProducts(id: category?.id ?? 0)
                .then((_) {
              pushNavigator(
                  context, CategoriesProductsPage(), slideRightToLeft);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: [
                // Non-circular image with rounded corners
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(
                        0.1), // subtle background for icon placeholder
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: category?.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: Uri.encodeFull(
                              'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(category!.imageUrl ?? '')}',
                            ),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Icons.broken_image,
                              size: 40,
                              color: primaryColor.withOpacity(0.5),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.category_outlined,
                          size: 40,
                          color: primaryColor.withOpacity(0.5),
                        ),
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    category?.name ?? 'No Name',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.productTitle(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

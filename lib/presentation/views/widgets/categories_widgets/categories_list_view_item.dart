import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/themes/themes.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/category_model/category_datum.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/categories_products_page.dart';

class CategoriesListViewItem extends StatelessWidget {
  final List<CategoryDatum> model;
  const CategoriesListViewItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: model.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 2 or 3 depending on screen width
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8, // Adjusts card height
        ),
        itemBuilder: (context, index) {
          final category = model[index];
          return InkWell(
            onTap: () {
              AppCubit.get(context)
                  .getCategoryProducts(id: category.id!)
                  .then((_) {
                pushNavigator(
                  context,
                  CategoriesProductsPage(categoryId: category.id!),
                  slideRightToLeft,
                );
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'http://smartlabel1.runasp.net/Uploads/${category.imageUrl}',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyles.productTitle(context)
                        .copyWith(fontSize: 12, color: primaryColor),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

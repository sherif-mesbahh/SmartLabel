import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/categories_list_view.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/grid_view_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          right: 8.0,
          left: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoriesListView(),
            Text(
              'Category Name',
              style: TextStyles.headline2,
            ),
            SizedBox(
              height: 10,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 10, // Space between columns
                mainAxisSpacing: 10, // Space between rows
                childAspectRatio: 1, // Adjust for item aspect ratio
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return GridViewItem();
              },
            ),
          ],
        ),
      ),
    );
  }
}

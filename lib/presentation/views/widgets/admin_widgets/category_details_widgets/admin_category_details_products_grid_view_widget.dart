import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_category_details_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/admin_category_product_grid_view_widget.dart';

class AdminCategoryDetailsProductsGridViewWidget extends StatelessWidget {
  const AdminCategoryDetailsProductsGridViewWidget({
    super.key,
    required this.widget,
  });

  final AdminCategoryDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: widget
          .cubit.categoryProductsModel!.data?.products!.length,
      itemBuilder: (context, index) {
        return AdminCategoryDetailsProductsGridViewItem(
          index: index,
          cubit: widget.cubit,
        );
      },
    );
  }
}


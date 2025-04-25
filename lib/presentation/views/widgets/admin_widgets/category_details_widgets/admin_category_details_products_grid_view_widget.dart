import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/admin_category_product_grid_view_widget.dart';

class AdminCategoryDetailsProductsGridViewWidget extends StatelessWidget {
  const AdminCategoryDetailsProductsGridViewWidget({
    super.key,
    required this.cubit,
    required this.categoryId,
  });

  final AppCubit cubit;
  final int categoryId;

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
      itemCount: cubit.categoryProductsModel!.data?.products!.length,
      itemBuilder: (context, index) {
        return AdminCategoryDetailsProductsGridViewItem(
          cubit: cubit,
          categoryId: categoryId,
          index: index,
          productId: cubit.categoryProductsModel!.data!.products![index].id!,
        );
      },
    );
  }
}

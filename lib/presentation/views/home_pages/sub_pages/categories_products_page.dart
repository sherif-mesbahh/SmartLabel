import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/shimmer_widget.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/grid_view_category_products_page_item.dart';

class CategoriesProductsPage extends StatelessWidget {
  final int categoryId;
  const CategoriesProductsPage({
    super.key,
    this.categoryId = 1,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).categoryProducts,
            style: TextStyles.appBarTitle(context)),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            popNavigator(context);
            cubit.getProducts();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            cubit.getCategoryProducts(id: categoryId),
          ]);
        },
        child: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            final products = cubit.categoryProductsModel?.data?.products;

            if (state is GetCategoryProductsLoadingState) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ShimmerBox(height: 100, width: 100);
                    }),
              );
            }

            if (products == null) {
              return Center(
                  child: Text(S.of(context).failedToLoadCategoryProducts,
                      style: TextStyle(color: Colors.red)));
            }

            if (products.isEmpty) {
              return Center(
                  child: Text(
                      S.of(context).noCategoryProductsFoundInThisCategory,
                      style: TextStyle(color: Colors.red)));
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GridViewCategoryProductsPageItem(
                          model: products[index],
                          categoryId: categoryId,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

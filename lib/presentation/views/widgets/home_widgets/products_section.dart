import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/shimmer_widget.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/products_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/grid_view_product_page_item.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final products = cubit.productModel?.data;
        if (state is GetProductsLoadingState) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: 6, // placeholder count
            itemBuilder: (context, index) => ShimmerBox(
              height: screenHeight(context) * .15,
              width: screenWidth(context) * .5,
            ),
          );
        }

        if (products == null) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).homePageNewProducts,
                      style:
                          TextStyles.headline2(context).copyWith(fontSize: 15)),
                  TextButton(
                    onPressed: () {
                      pushNavigator(
                        context,
                        ProductsPage(),
                        slideRightToLeft,
                      );
                      cubit.getProducts();
                    },
                    child: Text(S.of(context).seeAllButton,
                        style: TextStyles.buttonText(context)
                            .copyWith(fontSize: 12, color: primaryColor)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/failed_icon.png',
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(height: 8),
                    Text(S.of(context).failedToLoadProducts),
                  ],
                ),
              ),
            ],
          );
        }

        if (products.isEmpty) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).homePageNewProducts,
                      style:
                          TextStyles.headline2(context).copyWith(fontSize: 15)),
                  TextButton(
                    onPressed: () {
                      pushNavigator(
                        context,
                        ProductsPage(),
                        slideRightToLeft,
                      );
                      cubit.getProducts();
                    },
                    child: Text(S.of(context).seeAllButton,
                        style: TextStyles.buttonText(context)
                            .copyWith(fontSize: 12, color: primaryColor)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/failed_icon.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 8),
                    Text(S.of(context).noProductsFound),
                  ],
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).homePageNewProducts,
                    style:
                        TextStyles.headline2(context).copyWith(fontSize: 15)),
                TextButton(
                  onPressed: () {
                    pushNavigator(
                      context,
                      ProductsPage(),
                      slideRightToLeft,
                    );
                    cubit.getProducts();
                  },
                  child: Text(S.of(context).seeAllButton,
                      style: TextStyles.buttonText(context)
                          .copyWith(fontSize: 12, color: primaryColor)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: products.length > 10 ? 10 : products.length,
              itemBuilder: (context, index) =>
                  GridViewProductPageItem(model: products[index]),
            ),
          ],
        );
      },
    );
  }
}


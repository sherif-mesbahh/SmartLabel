import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/custom_slider.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/grid_view_product_page_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.productModel == null) {
        cubit.getProducts();
      }
      if (cubit.activeBannersModel == null) {
        cubit.getActiveBanners();
      }
    });

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                final cubit = AppCubit.get(context);
                final banners = cubit.activeBannersModel?.data;

                if (state is GetActiveBannersLoadingState) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    ),
                  );
                }

                if (banners == null || banners.isEmpty) {
                  return const SizedBox();
                }

                return CustomSlider(banners: banners);
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                final products = cubit.productModel?.data;

                if (state is GetProductsLoadingState) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    ),
                  );
                }

                if (products == null) {
                  return Center(
                      child: Text(S.of(context).failedToLoadProducts));
                }

                if (products.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Center(child: Text(S.of(context).noProductsFound)),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).homePageNewProducts,
                        style: TextStyles.headline2(context)),
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
                      itemBuilder: (context, index) =>
                          GridViewProductPageItem(model: products[index]),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

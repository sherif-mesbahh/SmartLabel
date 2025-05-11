import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_images_indicator_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_images_page_view_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_price_row_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  final int categoryId;
  final bool isSearchProduct;
  final String searchSort;
  final String searchOrder;
  ProductDetailsPage({
    super.key,
    this.categoryId = 1,
    this.isSearchProduct = true,
    this.searchSort = 'asc',
    this.searchOrder = 'id',
  });
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                if (AppCubit.get(context).navBarCurrentIndex == 0) {
                  AppCubit.get(context).getProducts();
                  AppCubit.get(context).getActiveBanners();
                  popNavigator(context);
                }
                if (AppCubit.get(context).navBarCurrentIndex == 1) {
                  popNavigator(context);
                }
                if (AppCubit.get(context).navBarCurrentIndex == 2) {
                  AppCubit.get(context).getFav();
                  popNavigator(context);
                }
                if (AppCubit.get(context).navBarCurrentIndex == 3) {
                  popNavigator(context);
                }
                if (isSearchProduct) {
                  AppCubit.get(context).getProductSearch(
                    name: '',
                    orderType: searchOrder,
                    sortType: searchSort,
                  );
                } else {
                  AppCubit.get(context).getCategorySearch(
                    name: '',
                    orderType: searchOrder,
                    sortType: searchSort,
                  );
                }
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: secondaryColor,
                size: 30,
              ),
            );
          },
        ),
        title: Text(S.of(context).productDetails,
            style: TextStyles.appBarTitle(context)),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is GetProductDetailsLoadingState) {}
        },
        child: BlocBuilder<AppCubit, AppStates>(
          buildWhen: (previous, current) =>
              current is GetProductDetailsSuccessState ||
              current is GetProductDetailsErrorState,
          builder: (context, state) {
            final product = cubit.productDetailsModel?.data;

            if (product == null) {
              return Center(
                child: Text(
                  S.of(context).failedToLoadProductDetails,
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? 'No Name',
                      style: TextStyles.headline2(context),
                    ),
                    const SizedBox(height: 10),
                    if (product.images != null && product.images!.isNotEmpty)
                      ProductImagesPageView(
                        pageController: pageController,
                        images: product.images!
                            .map((img) => img.imageUrl ?? '')
                            .where((url) => url.isNotEmpty)
                            .toList(),
                      )
                    else
                      Container(
                        height: screenHeight(context) * .3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 40),
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (product.images != null && product.images!.isNotEmpty)
                      ProductDetailsImagesIndicator(
                        pageController: pageController,
                        images: product.images!
                            .map((img) => img.imageUrl ?? '')
                            .where((url) => url.isNotEmpty)
                            .toList(),
                      ),
                    const SizedBox(height: 10),
                    ProductDetailsPriceRow(
                      newPrice: product.newPrice?.toString() ?? '0',
                      oldPrice: product.oldPrice?.toString() ?? '',
                      model: product,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).productDetailsDescription,
                      style: TextStyles.description(context).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.description?.trim().isNotEmpty == true
                          ? product.description!
                          : 'No description available.',
                      style: TextStyles.description(context),
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

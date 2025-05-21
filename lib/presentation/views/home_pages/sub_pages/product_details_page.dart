import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
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
    this.categoryId = 0,
    this.isSearchProduct = false,
    this.searchSort = 'asc',
    this.searchOrder = 'id',
  });
  final PageController pageController = PageController();

  Widget _buildShimmerPlaceholder(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title placeholder
          Container(
            height: 28,
            width: 200,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          // Image placeholder
          Container(
            height: screenHeight(context) * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),
          // Indicator placeholder
          Container(
            height: 10,
            width: 120,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          // Price row placeholder
          Container(
            height: 30,
            width: 140,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          // Description title placeholder
          Container(
            height: 22,
            width: 180,
            color: Colors.grey,
          ),
          const SizedBox(height: 8),
          // Description paragraph placeholder
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

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
                print("isSearchProduct: $isSearchProduct");
                print("searchOrder: $searchOrder, searchSort: $searchSort");

                if (isSearchProduct) {
                  AppCubit.get(context).getProductSearch(
                    name: '',
                    orderType: searchOrder,
                    sortType: searchSort,
                  );
                }
                if (AppCubit.get(context).navBarCurrentIndex == 0) {
                  AppCubit.get(context).getProducts();
                  AppCubit.get(context).getCategoryProducts(id: categoryId);

                  popNavigator(context);
                }
                if (AppCubit.get(context).navBarCurrentIndex == 1) {
                  AppCubit.get(context).getFav();
                  popNavigator(context);
                }
                if (AppCubit.get(context).navBarCurrentIndex == 2) {
                  popNavigator(context);
                }
                if (AppCubit.get(context).navBarCurrentIndex == 3) {
                  popNavigator(context);
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
      body: BlocBuilder<AppCubit, AppStates>(
        buildWhen: (previous, current) =>
            current is GetProductDetailsLoadingState ||
            current is GetProductDetailsSuccessState ||
            current is GetProductDetailsErrorState,
        builder: (context, state) {
          if (state is GetProductDetailsLoadingState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: _buildShimmerPlaceholder(context),
            );
          }

          if (state is GetProductDetailsErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/failed_icon.png',
                      height: 120,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).failedToLoadProductDetails,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }

          final product = cubit.productDetailsModel?.data;

          if (product == null) {
            return Center(
              child: Text(
                S.of(context).failedToLoadProductDetails,
                style: TextStyles.description(context),
              ),
            );
          }

          // SUCCESS STATE UI
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'No Name',
                    style: TextStyles.headline2(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (product.images != null && product.images!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ProductImagesPageView(
                        pageController: pageController,
                        images: product.images!
                            .map((img) => img.imageUrl ?? '')
                            .where((url) => url.isNotEmpty)
                            .toList(),
                      ),
                    )
                  else
                    Container(
                      height: screenHeight(context) * .3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(Icons.image_not_supported,
                            size: 56, color: Colors.grey),
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (product.images != null && product.images!.isNotEmpty)
                    ProductDetailsImagesIndicator(
                      pageController: pageController,
                      images: product.images!
                          .map((img) => img.imageUrl ?? '')
                          .where((url) => url.isNotEmpty)
                          .toList(),
                    ),
                  const SizedBox(height: 20),
                  ProductDetailsPriceRow(
                    newPrice: product.newPrice?.toString() ?? '0',
                    oldPrice: product.oldPrice?.toString() ?? '',
                    model: product,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    S.of(context).productDetailsDescription,
                    style: TextStyles.description(context).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description?.trim().isNotEmpty == true
                        ? product.description!
                        : 'No description available.',
                    style:
                        TextStyles.description(context).copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

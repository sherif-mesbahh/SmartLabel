import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_images_indicator_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_images_page_view_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_price_row_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            popNavigator(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
        title: Row(
          children: [
            const Image(
              height: 50,
              image: AssetImage('assets/images/smart_label_logo.png'),
            ),
            const SizedBox(width: 10),
            Text('Smart Label', style: TextStyles.appBarTitle),
          ],
        ),
      ),
      backgroundColor: secondaryColor,
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          final product = cubit.productDetailsModel?.data;

          if (state is GetProductDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (product == null) {
            return const Center(
              child: Text(
                'Failed to load product details.',
                style: TextStyle(color: Colors.red),
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
                    style: TextStyles.headline2,
                  ),

                  const SizedBox(height: 10),

                  // Handle null or empty images safely
                  if (product.images != null && product.images!.isNotEmpty)
                    ProductImagesPageView(
                      pageController: pageController,
                      images: product.images!,
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
                      images: product.images!,
                    ),

                  const SizedBox(height: 10),

                  ProductDetailsPriceRow(
                    newPrice: product.newPrice?.toString() ?? '0',
                    oldPrice: product.oldPrice?.toString() ?? '',
                    favorite: product.favorite ?? false,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Description:',
                    style: TextStyles.description.copyWith(
                      fontSize: 18,
                      color: darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.description?.trim().isNotEmpty == true
                        ? product.description!
                        : 'No description available.',
                    style: TextStyles.description,
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

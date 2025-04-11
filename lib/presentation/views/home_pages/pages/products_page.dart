import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/custom_slider.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/grid_view_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AppCubit.get(context);

        final products = cubit.productModel?.data;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSlider(banners: cubit.bannersModel?.data ?? []),
                const SizedBox(height: 10),
                if (state is GetProductsLoadingState)
                  const Center(child: CircularProgressIndicator())
                else if (products == null)
                  const Center(child: Text('Loading...'))
                else if (products.isEmpty)
                  const Center(child: Text('No Products Found'))
                else ...[
                  Text('New Products', style: TextStyles.headline2),
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
                      return GridViewItem(model: products[index]);
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

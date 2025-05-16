import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/themes/themes.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          S.of(context).productsAppBarTitle,
          style: TextStyles.appBarTitle(context),
        ),
        leading: IconButton(
          onPressed: () {
            AppCubit.get(context).getProducts();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);
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
              child: Text(
                S.of(context).failedToLoadProducts,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (products.isEmpty) {
            return Center(
              child: Text(
                S.of(context).noProductsFound,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await Future.wait([
                cubit.getProducts(),
              ]);
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  cubit: cubit,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

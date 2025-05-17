import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/home_page_shimmer.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/home_widgets/banner_section.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/home_widgets/categories_section.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/home_widgets/products_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      if (cubit.categoryModel == null) {
        cubit.getCategories();
      }
    });

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final isLoading = cubit.productModel == null ||
            cubit.activeBannersModel == null ||
            cubit.categoryModel == null ||
            state is GetCategoriesLoadingState ||
            state is GetProductsLoadingState ||
            state is GetActiveBannersLoadingState;

        if (isLoading) {
          return const HomePageShimmer(); 
        }
        return RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              cubit.getProducts(),
              cubit.getActiveBanners(),
              cubit.getCategories(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banners
                  BannerSection(cubit: cubit),
                  const SizedBox(height: 10),
                  // categories
                  CategoriesSecion(cubit: cubit),
                  const SizedBox(height: 10),
                  // products
                  ProductsSection(cubit: cubit),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

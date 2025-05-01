import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/categories_list_view_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        final categories = cubit.categoryModel?.data;

        if (state is GetCategoriesLoadingState) {
          return Center(
            child: Lottie.asset(
              'assets/lottie/loading_indicator.json',
              width: 100,
              height: 100,
            ),
          );
        }

        if (categories == null) {
          return const Center(child: Text('Failed to load categories'));
        }

        if (categories.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Text('No categories found')),
            ],
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) => CategoriesListViewItem(
                model: categories[index],
              ),
            ),
          ),
        );
      },
    );
  }
}

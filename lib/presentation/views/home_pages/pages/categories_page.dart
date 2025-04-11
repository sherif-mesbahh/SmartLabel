import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/categories_list_view_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    final categories = cubit.categoryModel?.data;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetCategoriesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }

        if (categories == null) {
          return const Center(child: Text('Loading...'));
        }

        if (categories.isEmpty) {
          return const Center(child: Text('No Categories Found'));
        }

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              right: 8.0,
              left: 8.0,
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable inside scroll
              shrinkWrap: true, // Prevent infinite height
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

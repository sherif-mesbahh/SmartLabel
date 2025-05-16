import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/themes/themes.dart';
import 'package:smart_label_software_engineering/core/utils/shimmer_widget.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/categories_list_view_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          S.of(context).categoriesAppBarr,
          style: TextStyles.appBarTitle(context),
        ),
        leading: IconButton(
          onPressed: () {
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
          final categories = cubit.categoryModel?.data;

          if (state is GetCategoriesLoadingState) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) => ShimmerBox(
                  height: 100,
                  width: 100,
                ),
                itemCount: 12,
              ),
            );
          }

          if (categories == null) {
            return Center(
              child: Text(
                S.of(context).failedToLoadCategories,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (categories.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    S.of(context).noCategoriesFound,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }

          return CategoriesListViewItem(model: categories);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_widgets/admin_categories_grid_view_item_widget.dart';

class AdminCategoriesSectionWidget extends StatelessWidget {
  const AdminCategoriesSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppStates>(
      listener: (context, state) {},
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio:
              screenWidth(context) / (screenHeight(context) * 0.5),
        ),
        itemCount: AppCubit.get(context).categoryModel?.data?.length,
        itemBuilder: (context, index) {
          return AdminCategoriesGridViewItem(
            index: index,
            cubit: AppCubit.get(context),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/add_new_category_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/admin_categories_grid_view_item_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/edit_banners_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/custom_slider.dart';

class AdminCategoriesPage extends StatelessWidget {
  AdminCategoriesPage({super.key});
  final TextEditingController categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Text(
              'Admin Panel',
              style: TextStyles.appBarTitle,
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSlider(banners: [],),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'All Categories',
                        style: TextStyles.headline2,
                      ),
                      Spacer(),
                      TextButton(
                        child: Text(
                          'Edit Banners',
                          style: TextStyles.productTitle
                              .copyWith(color: primaryColor),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditBannersDialogWidget(),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 10, // Space between columns
                      mainAxisSpacing: 10, // Space between rows
                      childAspectRatio: 1, // Adjust for item aspect ratio
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return AdminCategoriesGridViewItem();
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.add,
              color: secondaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddNewCategoryDialog(),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/add_new_product_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/admin_category_product_grid_view_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/edit_category_image_dialog.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/edit_category_name_dialog_widget.dart';

class AdminEditCategoryPage extends StatelessWidget {
  const AdminEditCategoryPage({super.key});

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
              'Edit Category',
              style: TextStyles.appBarTitle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Category Name',
                        style: TextStyles.headline2,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditCategoryNameDialog(
                              categoryId: 1,
                            ),
                          );
                        },
                        child: Text(
                          'Edit Name',
                          style: TextStyles.productTitle
                              .copyWith(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image(
                        height: screenHeight(context) * .15,
                        width: screenWidth(context) * .3,
                        image: AssetImage(
                          'assets/images/fruits_image.jpg',
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditCategoryImageDialog(
                              categoryId: 1,
                            ),
                          );
                        },
                        child: Text(
                          'Edit Image',
                          style: TextStyles.productTitle
                              .copyWith(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Category Name Products',
                    style: TextStyles.headline2,
                  ),
                  SizedBox(height: 10),
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
                      return AdminCategoryProductsGridViewItem();
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
                builder: (context) => AddNewProductDialog(
                  categoryId: 1,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

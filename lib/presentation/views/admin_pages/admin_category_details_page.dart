import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/add_new_product_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/admin_category_details_app_bar_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/admin_category_details_edit_image_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/admin_category_details_name_text_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/admin_category_details_products_grid_view_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/category_details_save_and_discard_button_widget.dart';

class AdminCategoryDetailsPage extends StatefulWidget {
  const AdminCategoryDetailsPage({
    super.key,
    required this.cubit,
    required this.categoryId,
  });
  final AppCubit cubit;
  final int categoryId;

  @override
  State<AdminCategoryDetailsPage> createState() =>
      _AdminCategoryDetailsPageState();
}

class _AdminCategoryDetailsPageState extends State<AdminCategoryDetailsPage> {
  final TextEditingController nameController = TextEditingController();
  bool hasTextFieldChanged = false;

  @override
  void initState() {
    super.initState();
    final category = widget.cubit.categoryProductsModel!.data;

    if (category != null) {
      nameController.text = category.name ?? "";
    }
    nameController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      hasTextFieldChanged = true;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(_onTextChanged);
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AdminCategoryDetailsAppBarWidget(cubit: cubit),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is UpdateCategorySuccessState) {
            Fluttertoast.showToast(
              msg: 'Category Updated Successfully',
              backgroundColor: Colors.green,
              textColor: secondaryColor,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 1,
              fontSize: 16,
            );
            cubit.getCategories().then((onValue) {
              cubit.mainCategoryImageToUpload = null;
              popNavigator(context);
            });
          }
          if (state is UpdateCategoryErrorState) {
            Fluttertoast.showToast(
              msg: state.error,
              backgroundColor: Colors.red,
              textColor: secondaryColor,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 1,
              fontSize: 16,
            );
          }

          if (state is DeleteProductSuccessState) {
            Fluttertoast.showToast(
              msg: 'Product Deleted Successfully',
              backgroundColor: Colors.green,
              textColor: secondaryColor,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 1,
              fontSize: 16,
            );
          }
          if (state is DeleteProductErrorState) {
            Fluttertoast.showToast(
              msg: 'Error while Deleting Product, try again',
              backgroundColor: Colors.red,
              textColor: secondaryColor,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 1,
              fontSize: 16,
            );
          }
        },
        builder: (context, state) {
          final category = cubit.categoryProductsModel?.data;
          final products = cubit.categoryProductsModel!.data!.products;
          if (category == null) {
            return const Center(
              child: Text(
                "No Category details available.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Name
                AdminCategoryDetailsNameTextFieldWidget(
                    nameController: nameController),
                SizedBox(height: 10),

                // Category Image
                AdminCategoryDetailsEditImageWidget(
                  cubit: cubit,
                  category: category,
                ),
                // Save and Discard
                SizedBox(height: 10),
                if (hasTextFieldChanged ||
                    cubit.mainCategoryImageToUpload != null)
                  CategoryDetailsSaveAndDiscardButtonWidget(
                    cubit: cubit,
                    widget: widget,
                    nameController: nameController,
                  ),
                SizedBox(height: 10),

                // Category Products
                Text(
                  '${widget.cubit.categoryProductsModel!.data?.name ?? ''} Products',
                  style: TextStyles.headline2,
                ),
                SizedBox(height: 10),
                products != null && products.isNotEmpty
                    ? AdminCategoryDetailsProductsGridViewWidget(
                        cubit: cubit,
                        categoryId: category.id!,
                      )
                    : Center(
                        child: Text(
                          'No Products Available for this Category',
                          style: TextStyles.productTitle,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
      // Add Product
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: secondaryColor,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddProductDialogWidget(
              categoryId: widget.categoryId,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/product_details_model/product_details_data_images_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/product_details_widgets/admin_product_details_add_image_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/product_details_widgets/admin_product_details_images_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/product_details_widgets/admin_product_details_main_image_row_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/product_details_widgets/admin_product_details_save_and_discard_button_widget.dart';

class AdminProductDetailsPage extends StatefulWidget {
  const AdminProductDetailsPage({
    super.key,
    required this.productId,
    required this.categoryId,
    required this.cubit,
  });
  final int productId;
  final int categoryId;
  final AppCubit cubit;

  @override
  State<AdminProductDetailsPage> createState() =>
      _AdminProductDetailsPageState();
}

class _AdminProductDetailsPageState extends State<AdminProductDetailsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  bool hasTextFieldChanged = false;
  @override
  void initState() {
    super.initState();
    final product = widget.cubit.productDetailsModel?.data;

    if (product != null) {
      nameController.text = product.name ?? "";
      descController.text = product.description ?? "";
      discountController.text = product.discount.toString();
      priceController.text = product.oldPrice.toString();
    }
    nameController.addListener(_onTextChanged);
    discountController.addListener(_onTextChanged);
    priceController.addListener(_onTextChanged);
    descController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      hasTextFieldChanged = true;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(_onTextChanged);
    discountController.removeListener(_onTextChanged);
    priceController.removeListener(_onTextChanged);
    descController.removeListener(_onTextChanged);
    nameController.dispose();
    descController.dispose();
    discountController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            cubit.productImagesToUpload = [];
            cubit.productImagesToDelete = [];
            cubit.mainproductImageToUpload = null;
            hasTextFieldChanged = false;
            popNavigator(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Product',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              if (state is UpdateProductSuccessState) {
                Fluttertoast.showToast(
                  msg: 'Product Updated Successfully',
                  backgroundColor: Colors.green,
                  textColor: secondaryColor,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 1,
                  fontSize: 16,
                );
                widget.cubit
                    .getCategoryProducts(
                        id: widget
                                .cubit.productDetailsModel!.data!.categoryId ??
                            1)
                    .then((onValue) {
                  popNavigator(context);
                });
              }
              if (state is UpdateProductErrorState) {
                Fluttertoast.showToast(
                  msg: 'Error while Updating Product, try again',
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
              final product = widget.cubit.productDetailsModel?.data!;

              final List<ProductDetailsDataImagesModel> productImages = product
                      ?.images
                      ?.where((img) =>
                          img.imageUrl != null && img.imageUrl!.isNotEmpty)
                      .toList() ??
                  [];

              if (product == null) {
                return const Center(
                  child: Text(
                    "No Product details available.",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main image
                  ProductDetailsMainImageWidget(cubit: widget.cubit),
                  SizedBox(height: 10),
                  // Product images
                  if (productImages.isNotEmpty)
                    ProductDetailsImagesWidget(
                        product: product, productImages: productImages),
                  SizedBox(height: 10),
                  // Add product images
                  ProductDetailsAddImagesWidget(
                      cubit: widget.cubit, product: product),
                  // Name
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyles.smallText,
                      hintStyle: TextStyles.smallText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // price
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyles.smallText,
                      hintStyle: TextStyles.smallText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Discount
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: discountController,
                    decoration: InputDecoration(
                      labelText: 'Discount',
                      labelStyle: TextStyles.smallText,
                      hintStyle: TextStyles.smallText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Description
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: descController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyles.smallText,
                      hintStyle: TextStyles.smallText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                  if (hasTextFieldChanged ||
                      cubit.productImagesToDelete.isNotEmpty ||
                      cubit.productImagesToUpload.isNotEmpty ||
                      cubit.mainproductImageToUpload != null)
                    ProductDetailsSaveAndDiscardButtonsWidget(
                      cubit: cubit,
                      categoryId: widget.categoryId,
                      productId: widget.productId,
                      nameController: nameController,
                      descController: descController,
                      discountController: discountController,
                      priceController: priceController,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class ProductDetailsSaveAndDiscardButtonsWidget extends StatelessWidget {
  const ProductDetailsSaveAndDiscardButtonsWidget({
    super.key,
    required this.cubit,
    required this.categoryId,
    required this.productId,
    required this.nameController,
    required this.descController,
    required this.discountController,
    required this.priceController,
  });

  final AppCubit cubit;
  final int categoryId;
  final int productId;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController discountController;
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8.0,
      ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Save Changes
              state is UpdateProductLoadingState
                  ? Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 50,
                      height: 50,
                    )
                  : InkWell(
                      child: Text(
                        'Save changes',
                        style: TextStyles.productTitle(context)
                            .copyWith(color: primaryColor),
                      ),
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Name must not be empty.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        final price = double.tryParse(priceController.text);
                        if (priceController.text.isEmpty ||
                            price == null ||
                            price <= 0) {
                          Fluttertoast.showToast(
                            msg: "Price must be a valid positive number.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        final discountText = discountController.text.trim();
                        final discount = double.tryParse(discountText);

                        if (discountText.isEmpty || discount == null) {
                          Fluttertoast.showToast(
                            msg:
                                "Discount must be a valid whole number (e.g., 10).",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        if (discount % 1 != 0 ||
                            discount < 0 ||
                            discount > 100) {
                          Fluttertoast.showToast(
                            msg:
                                "Discount must be a valid whole number between 0 and 100.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        cubit
                            .updateProduct(
                          productId: productId,
                          categoryId: categoryId,
                          name: nameController.text,
                          description: descController.text,
                          mainImage: cubit.mainproductImageToUpload,
                          imageFiles: cubit.productImagesToUpload,
                          imagesToDelete: cubit.productImagesToDelete,
                          discount: discountController.text,
                          price: priceController.text,
                        )
                            .then((_) async {
                          await cubit.getCategoryProducts(id: categoryId);
                          await cubit.getProductDetails(id: productId);
                        });
                      },
                    ),
              // Discard
              InkWell(
                child: Text(
                  'Discard',
                  style: TextStyles.productTitle(context)
                      .copyWith(color: primaryColor),
                ),
                onTap: () {
                  cubit.productImagesToUpload = [];
                  cubit.productImagesToDelete = [];
                  cubit.mainproductImageToUpload = null;
                  popNavigator(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

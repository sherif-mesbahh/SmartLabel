import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
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
    required this.formKey,
  });

  final AppCubit cubit;
  final int categoryId;
  final int productId;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController discountController;
  final TextEditingController priceController;
  final GlobalKey<FormState> formKey;

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
                        S.of(context).editProductSaveChangesButton,
                        style: TextStyles.productTitle(context)
                            .copyWith(color: primaryColor),
                      ),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
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
                        }
                      },
                    ),
              // Discard
              InkWell(
                child: Text(
                  S.of(context).editProductDiscardChangesButton,
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

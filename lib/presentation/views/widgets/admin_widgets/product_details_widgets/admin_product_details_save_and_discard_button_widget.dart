import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      width: 100,
                      height: 100,
                    )
                  : InkWell(
                      child: Text(
                        'Save changes',
                        style: TextStyles.productTitle
                            .copyWith(color: primaryColor),
                      ),
                      onTap: () {
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
                            .then((_) {
                          cubit.productImagesToUpload = [];
                          cubit.productImagesToDelete = [];
                          cubit.mainproductImageToUpload = null;

                          cubit.getCategoryProducts(id: categoryId);
                        });
                      },
                    ),
              // Discard
              InkWell(
                child: Text(
                  'Discard',
                  style: TextStyles.productTitle.copyWith(color: primaryColor),
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

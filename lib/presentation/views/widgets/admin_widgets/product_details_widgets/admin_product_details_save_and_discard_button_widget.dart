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
                  : IntrinsicWidth(
                      child: TextButton(
                        onPressed: () {
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
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              primaryColor.withOpacity(0.25)),
                          foregroundColor:
                              WidgetStateProperty.all(primaryColor),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                  color: primaryColor.withOpacity(0.4)),
                            ),
                          ),
                          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                            (states) {
                              if (states.contains(WidgetState.pressed)) {
                                return primaryColor.withOpacity(0.2);
                              }
                              if (states.contains(WidgetState.hovered)) {
                                return primaryColor.withOpacity(0.15);
                              }
                              return null;
                            },
                          ),
                          textStyle: WidgetStateProperty.all(
                            TextStyles.productTitle(context)
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        child: Text(S.of(context).editProductSaveChangesButton),
                      ),
                    ),
              TextButton(
                onPressed: () {
                  cubit.productImagesToUpload = [];
                  cubit.productImagesToDelete = [];
                  cubit.mainproductImageToUpload = null;
                  popNavigator(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.red.withOpacity(0.15),
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.red),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.red.withOpacity(0.4)),
                    ),
                  ),
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.red.withOpacity(0.2);
                      }
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.red.withOpacity(0.15);
                      }
                      return null;
                    },
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyles.productTitle(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
                child: Text(S.of(context).editProductDiscardChangesButton),
              ),
            ],
          );
        },
      ),
    );
  }
}

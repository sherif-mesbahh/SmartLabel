import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_category_details_page.dart';

class CategoryDetailsSaveAndDiscardButtonWidget extends StatelessWidget {
  const CategoryDetailsSaveAndDiscardButtonWidget({
    super.key,
    required this.cubit,
    required this.widget,
    required this.nameController,
    required this.formKey,
  });

  final AppCubit cubit;
  final AdminCategoryDetailsPage widget;
  final TextEditingController nameController;
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
              state is UpdateCategoryLoadingState
                  ? Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    )
                  : TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit
                              .updateCategory(
                            id: widget.categoryId,
                            name: nameController.text,
                            categoryImage: cubit.mainCategoryImageToUpload,
                          )
                              .then((_) {
                            cubit.getCategoryProducts(id: widget.categoryId);
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            primaryColor.withOpacity(0.25)),
                        foregroundColor: WidgetStateProperty.all(primaryColor),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 20),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                                color: primaryColor.withOpacity(0.4)),
                          ),
                        ),
                        overlayColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
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
                      child: Text(S.of(context).editCategorySaveChangesButton),
                    ),

              // Discard Changes
              TextButton(
                onPressed: () {
                  cubit.mainCategoryImageToUpload = null;
                  popNavigator(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.red.withOpacity(0.15)),
                  foregroundColor: WidgetStateProperty.all(Colors.red),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
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
                        return Colors.red.withOpacity(0.1);
                      }
                      return null;
                    },
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyles.productTitle(context)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                child: Text(S.of(context).editCategoryDiscardChangesButton),
              ),
            ],
          );
        },
      ),
    );
  }
}

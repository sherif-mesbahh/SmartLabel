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
                  : InkWell(
                      child: Text(
                        S.of(context).editCategorySaveChangesButton,
                        style: TextStyles.productTitle(context)
                            .copyWith(color: primaryColor),
                      ),
                      onTap: () {
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
                    ),
              // Discard
              InkWell(
                child: Text(
                  S.of(context).editCategoryDiscardChangesButton,
                  style: TextStyles.productTitle(context)
                      .copyWith(color: primaryColor),
                ),
                onTap: () {
                  cubit.mainCategoryImageToUpload = null;
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

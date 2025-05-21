import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/category_model/category_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_category_details_page.dart';

class AdminCategoriesGridViewItem extends StatelessWidget {
  const AdminCategoriesGridViewItem({
    super.key,
    required this.index,
    required this.cubit,
  });
  final int index;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoryModel? categoryModel = cubit.categoryModel;
        return InkWell(
          onTap: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: Lottie.asset(
                  'assets/lottie/loading_indicator.json',
                  width: 100,
                  height: 100,
                ),
              ),
            );

            await cubit.getCategoryProducts(
                id: categoryModel?.data![index].id ?? 1);

            if (context.mounted) {
              Navigator.of(context).pop();
            }

            if (context.mounted) {
              pushNavigator(
                context,
                AdminCategoryDetailsPage(
                  cubit: cubit,
                  categoryId: categoryModel?.data?[index].id ?? 1,
                ),
                slideRightToLeft,
              );
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: Uri.encodeFull(
                            'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(categoryModel?.data?[index].imageUrl ?? '')}'),
                        height: screenHeight(context) * 0.15,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: Lottie.asset(
                            'assets/lottie/loading_indicator.json',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        categoryModel?.data?[index].name ?? '',
                        style: TextStyles.productTitle(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Delete button
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Octicons.trash, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocBuilder<AppCubit, AppStates>(
                            builder: (context, state) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: Text(
                                  S.of(context).categoryConfirmDeletion,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content:
                                    Text(S.of(context).categoryDeletionText),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(S
                                        .of(context)
                                        .categoryDeletionCancelButton),
                                  ),
                                  TextButton(
                                    onPressed:
                                        state is DeleteCategoryLoadingState
                                            ? null
                                            : () {
                                                cubit
                                                    .deleteCategory(
                                                        id: categoryModel
                                                                ?.data?[index]
                                                                .id ??
                                                            1)
                                                    .then((_) =>
                                                        Navigator.of(context)
                                                            .pop());
                                              },
                                    child: state is DeleteCategoryLoadingState
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Lottie.asset(
                                              'assets/lottie/loading_indicator.json',
                                            ),
                                          )
                                        : Text(
                                            S
                                                .of(context)
                                                .categoryDeletionDeleteButton,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

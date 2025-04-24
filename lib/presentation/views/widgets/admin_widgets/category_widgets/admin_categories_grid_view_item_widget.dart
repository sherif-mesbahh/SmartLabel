import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
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
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: primaryColor),
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
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          'http://smartlabel1.runasp.net/Uploads/${categoryModel?.data?[index].imageUrl}',
                      height: screenHeight(context) * .2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 10),
                  // name
                  Text(
                    categoryModel?.data?[index].name ?? '',
                    style: TextStyles.productTitle,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              // delete button
              Positioned(
                top: -10,
                right: -10,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocBuilder<AppCubit, AppStates>(
                          builder: (context, state) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                  'Are you sure you want to delete this category?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: state is DeleteCategoryLoadingState
                                      ? null
                                      : () {
                                          cubit
                                              .deleteCategory(
                                                  id: categoryModel
                                                          ?.data![index].id ??
                                                      1)
                                              .then((_) {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                  child: state is DeleteCategoryLoadingState
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
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

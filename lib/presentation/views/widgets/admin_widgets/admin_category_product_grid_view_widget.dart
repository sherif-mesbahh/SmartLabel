import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class AdminCategoryDetailsProductsGridViewItem extends StatelessWidget {
  const AdminCategoryDetailsProductsGridViewItem({
    super.key,
    required this.index,
    required this.cubit,
  });
  final int index;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // pushNavigator(context, AdminEditProductPage(), slideRightToLeft);
      },
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:
                      'http://smartlabel1.runasp.net/Uploads/${cubit.categoryProductsModel?.data!.products?[index].mainImage}',
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
              Text(
                cubit.categoryProductsModel?.data!.products?[index].name ?? '',
                style: TextStyles.productTitle,
              ),
            ],
          ),
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
                              'Are you sure you want to delete this Product?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: state is DeleteProductLoadingState
                                  ? null
                                  : () {
                                      cubit
                                          .deleteProduct(
                                              productId: cubit
                                                      .categoryProductsModel!
                                                      .data
                                                      ?.products?[index]
                                                      .id ??
                                                  1,
                                              cateoryId: cubit
                                                      .categoryProductsModel
                                                      ?.data!
                                                      .id ??
                                                  1)
                                          .then((_) {
                                        Navigator.of(context).pop();
                                      });
                                    },
                              child: state is DeleteProductLoadingState
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
  }
}

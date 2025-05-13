import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_product_details_page.dart';

class AdminCategoryDetailsProductsGridViewItem extends StatelessWidget {
  const AdminCategoryDetailsProductsGridViewItem({
    super.key,
    required this.cubit,
    required this.categoryId,
    required this.productId,
    required this.index,
  });
  final int categoryId;
  final AppCubit cubit;
  final int productId;
  final int index;

  @override
  Widget build(BuildContext context) {
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

        await AppCubit.get(context).getProductDetails(id: productId);

        if (context.mounted) {
          Navigator.of(context).pop();
        }

        if (context.mounted) {
          pushNavigator(
            context,
            AdminProductDetailsPage(
              cubit: cubit,
              productId: productId,
              categoryId: categoryId,
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
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:
                      'http://smartlabel1.runasp.net/Uploads/${cubit.categoryProductsModel?.data!.products?[index].mainImage}',
                  height: screenHeight(context) * .15,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Lottie.asset(
                      'assets/lottie/loading_indicator.json',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 10),
              // Product Name
              Text(
                cubit.categoryProductsModel?.data!.products?[index].name ?? '',
                style: TextStyles.productTitle(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          // Delete Button
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
                          title: Text(
                            S.of(context).productConfirmDeletion,
                          ),
                          content: Text(
                            S.of(context).productConfirmDeletionText,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                S.of(context).productDeletionCancelButton,
                              ),
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
                                      child: Lottie.asset(
                                        'assets/lottie/loading_indicator.json',
                                        width: 100,
                                        height: 100,
                                      ),
                                    )
                                  : Text(
                                      S.of(context).productDeletionDeleteButton,
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

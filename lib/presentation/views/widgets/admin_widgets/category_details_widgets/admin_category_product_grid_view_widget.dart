import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: Uri.encodeFull(
                          'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(cubit.categoryProductsModel?.data!.products?[index].mainImage ?? '')}'),
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Product Name
                  Text(
                    cubit.categoryProductsModel?.data!.products?[index].name ??
                        '',
                    style: TextStyles.productTitle(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Prices
                  Builder(builder: (_) {
                    final product =
                        cubit.categoryProductsModel?.data!.products?[index];
                    final newPrice = product?.newPrice ?? 0;
                    final oldPrice = product?.oldPrice ?? 0;
                    final hasDiscount = oldPrice > newPrice;

                    return Row(
                      children: [
                        Text(
                          '\$${newPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (hasDiscount)
                          Text(
                            '\$${oldPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),

          // 🔴 Discount badge at top-left
          if ((cubit.categoryProductsModel?.data!.products?[index].oldPrice ??
                  0) >
              (cubit.categoryProductsModel?.data!.products?[index].newPrice ??
                  0))
            Positioned(
              top: 24,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '-${(((cubit.categoryProductsModel!.data!.products![index].oldPrice! - cubit.categoryProductsModel!.data!.products![index].newPrice!) / cubit.categoryProductsModel!.data!.products![index].oldPrice!) * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

          // 🗑️ Delete Button at top-right
          Positioned(
            top: 18,
            right: 10,
            child: Material(
              elevation: 4,
              shape: const CircleBorder(),
              color: Theme.of(context).colorScheme.surface,
              child: IconButton(
                icon: const Icon(Octicons.trash, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BlocBuilder<AppCubit, AppStates>(
                        builder: (context, state) {
                          return AlertDialog(
                            title: Text(S.of(context).productConfirmDeletion),
                            content:
                                Text(S.of(context).productConfirmDeletionText),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                    S.of(context).productDeletionCancelButton),
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
                                          cateoryId: cubit.categoryProductsModel
                                                  ?.data!.id ??
                                              1,
                                        )
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
                                        ),
                                      )
                                    : Text(
                                        S
                                            .of(context)
                                            .productDeletionDeleteButton,
                                        style:
                                            const TextStyle(color: Colors.red),
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
  }
}

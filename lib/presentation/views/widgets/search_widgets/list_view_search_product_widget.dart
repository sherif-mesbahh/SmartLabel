import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class ListViewSearchProductWidget extends StatelessWidget {
  const ListViewSearchProductWidget({
    super.key,
    required this.cubit,
    required this.index,
    this.isPrloduct = true,
    required this.searchOrder,
    required this.searchSort,
  });

  final AppCubit cubit;
  final int index;
  final bool isPrloduct;
  final String searchOrder;
  final String searchSort;

  @override
  Widget build(BuildContext context) {
    final product = cubit.productSearchModel?.data?[index];
    final hasDiscount = product?.newPrice != product?.oldPrice;

    return InkWell(
      onTap: () {
        AppCubit.get(context).getProductDetails(id: product?.id ?? 0).then((_) {
          pushNavigator(
            context,
            ProductDetailsPage(
              isSearchProduct: true,
              searchOrder: searchOrder,
              searchSort: searchSort,
            ),
            slideRightToLeft,
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: screenHeight(context) * 0.16,
                    width: screenWidth(context) * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: product?.mainImage != null
                            ? Uri.encodeFull(
                                'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(product!.mainImage ?? '')}')
                            : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: Lottie.asset(
                            'assets/lottie/loading_indicator.json',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  if (hasDiscount)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "${product?.discount}% ${S.of(context).off}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product?.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.productTitle(context).copyWith(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${product?.newPrice}\$',
                            style: TextStyles.productPrice(context)
                                .copyWith(fontSize: 14),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 8),
                            Text(
                              '${product?.oldPrice}\$',
                              style:
                                  TextStyles.productOldPrice(context).copyWith(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<AppCubit, AppStates>(
                builder: (context, state) {
                  final bool favorite = product?.favorite ?? false;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                    child: InkWell(
                      onTap: () {
                        if (AppCubit.get(context).isLogin) {
                          favorite
                              ? cubit.removeFromFav(model: product!)
                              : cubit.addToFav(model: product!);
                        } else {
                          Fluttertoast.showToast(
                            msg: S.of(context).youMustBeLoggedIn,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                        color: favorite ? Colors.red : Colors.grey,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

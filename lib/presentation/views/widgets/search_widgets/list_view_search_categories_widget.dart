import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/categories_products_page.dart';

class ListViewSearchCategoriesWidget extends StatelessWidget {
  const ListViewSearchCategoriesWidget({
    super.key,
    required this.cubit,
    required this.index,
  });

  final AppCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: primaryColor,
            child: CircleAvatar(
              onBackgroundImageError: (exception, stackTrace) =>
                  Icon(Icons.error),
              radius: 40,
              backgroundImage: CachedNetworkImageProvider(
                'http://smartlabel1.runasp.net/Uploads/${cubit.categorySearchModel?.data?[index].imageUrl}',
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 10,
            child: Text(
              cubit.categorySearchModel?.data?[index].name ?? 'No Name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyles.productTitle,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .getCategoryProducts(
                      id: cubit.categorySearchModel?.data?[index].id ?? 0)
                  .then((onValue) {
                pushNavigator(
                    context, CategoriesProductsPage(), slideRightToLeft);
              });
            },
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

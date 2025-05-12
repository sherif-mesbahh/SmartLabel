import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/search_widgets/list_view_search_categories_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/search_widgets/list_view_search_product_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/search_widgets/search_custom_text_widget.dart';

class SearchItemsList extends StatelessWidget {
  const SearchItemsList({
    super.key,
    required this.selectedType,
    required this.cubit,
    this.searchOrder = 'id',
    this.searchSort = 'asc',
  });

  final String selectedType;
  final String searchOrder;
  final String searchSort;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    // Directly use the selectedType and cubit to simplify and avoid unnecessary widget rebuilding
    final isProduct = selectedType == 'Products';
    final hasResults = isProduct
        ? (cubit.productSearchModel?.data?.isNotEmpty ?? false)
        : (cubit.categorySearchModel?.data?.isNotEmpty ?? false);

    if (!hasResults) {
      return SearchCustomTextWidget(
        text: S.of(context).noItemsFoundWithThisName,
      );
    }

    // Use ListView.builder for performance when the list is potentially long
    return Expanded(
      child: ListView.builder(
        itemCount: selectedType == 'Products'
            ? cubit.productSearchModel?.data?.length ?? 0
            : cubit.categorySearchModel?.data?.length ?? 0,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          // Directly return the appropriate widget based on selectedType
          if (selectedType == 'Products') {
            return ListViewSearchProductWidget(
              isPrloduct: isProduct,
              searchOrder: searchOrder,
              searchSort: searchSort,
              cubit: cubit,
              index: index,
            );
          } else if (selectedType == 'Categories') {
            return ListViewSearchCategoriesWidget(cubit: cubit, index: index);
          } else {
            return SearchCustomTextWidget(
              text: S.of(context).searchForAnyItem,
            );
          }
        },
      ),
    );
  }
}

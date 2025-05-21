import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/search_widgets/search_app_bar_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/search_widgets/search_items_list_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selectedType = 'Products';
  late String selectedSort;
  late String selectedOrder;
  bool _isInitialized = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // This ensures the block runs only once
    if (!_isInitialized) {
      selectedSort = S.of(context).searchSortProductsByDefault;
      selectedOrder = S.of(context).searchOrderByAsc;

      final cubit = AppCubit.get(context);
      cubit.getProductSearch(
        name: searchController.text,
        sortType: 'id',
        orderType: 'asc',
      );
      cubit.getCategorySearch(
        name: searchController.text,
        sortType: 'id',
        orderType: 'asc',
      );

      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SearchAppBar(),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);

          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Use Row for ChoiceChips only when needed
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: Row(
                      key: ValueKey<String>(selectedType),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildChoiceChip(
                          context,
                          label: S.of(context).searchProductsLabel,
                          icon: Icons.shopping_bag,
                          isSelected: selectedType == 'Products',
                          onSelected: () {
                            setState(() {
                              selectedType = 'Products';
                              selectedSort =
                                  S.of(context).searchSortProductsByDefault;
                              selectedOrder = S.of(context).searchOrderByAsc;
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildChoiceChip(
                          context,
                          label: S.of(context).searchCategoriesLabel,
                          icon: Icons.category,
                          isSelected: selectedType == 'Categories',
                          onSelected: () {
                            setState(() {
                              selectedType = 'Categories';
                              selectedSort =
                                  S.of(context).searchSortCategoriesByDefault;
                              selectedOrder = S.of(context).searchOrderByAsc;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: Row(
                      key: ValueKey('$selectedSort$selectedOrder'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStyledDropdown<String>(
                          context: context,
                          value: selectedSort,
                          items: (selectedType == 'Products'
                                  ? [
                                      S.of(context).searchSortProductsByDefault,
                                      S.of(context).searchSortProductsByName,
                                      S.of(context).searchSortProductsByPrice,
                                    ]
                                  : [
                                      S
                                          .of(context)
                                          .searchSortCategoriesByDefault,
                                      S.of(context).searchSortCategoriesByName,
                                    ])
                              .map((sortOption) => DropdownMenuItem(
                                    value: sortOption,
                                    child: Text(
                                      sortOption[0].toUpperCase() +
                                          sortOption.substring(1),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (newValue) async {
                            setState(() => selectedSort = newValue!);
                            final isDefault = selectedSort ==
                                    S.of(context).searchSortProductsByDefault ||
                                selectedSort ==
                                    S.of(context).searchSortCategoriesByDefault;
                            final isPrice = selectedSort ==
                                S.of(context).searchSortProductsByPrice;
                            final sortKey = isDefault
                                ? 'id'
                                : (isPrice ? 'new-price' : 'name');
                            if (selectedType == 'Products') {
                              await cubit.getProductSearch(
                                name: searchController.text,
                                sortType: sortKey,
                                orderType: selectedOrder ==
                                        S.of(context).searchOrderByAsc
                                    ? 'asc'
                                    : 'desc',
                              );
                            } else {
                              await cubit.getCategorySearch(
                                name: searchController.text,
                                sortType: sortKey,
                                orderType: selectedOrder ==
                                        S.of(context).searchOrderByAsc
                                    ? 'asc'
                                    : 'desc',
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 10),
                        _buildStyledDropdown<String>(
                          context: context,
                          value: selectedOrder,
                          items: [
                            S.of(context).searchOrderByAsc,
                            S.of(context).searchOrderByDesc,
                          ]
                              .map((orderOption) => DropdownMenuItem(
                                    value: orderOption,
                                    child: Text(orderOption,
                                        style: const TextStyle(fontSize: 14)),
                                  ))
                              .toList(),
                          onChanged: (newValue) async {
                            setState(() => selectedOrder = newValue!);
                            final isDefault = selectedSort ==
                                    S.of(context).searchSortProductsByDefault ||
                                selectedSort ==
                                    S.of(context).searchSortCategoriesByDefault;
                            final isPrice = selectedSort ==
                                S.of(context).searchSortProductsByPrice;
                            final sortKey = isDefault
                                ? 'id'
                                : (isPrice ? 'new-price' : 'name');
                            final orderKey =
                                selectedOrder == S.of(context).searchOrderByAsc
                                    ? 'asc'
                                    : 'desc';
                            if (selectedType == 'Products') {
                              await cubit.getProductSearch(
                                name: searchController.text,
                                sortType: sortKey,
                                orderType: orderKey,
                              );
                            } else {
                              await cubit.getCategorySearch(
                                name: searchController.text,
                                sortType: sortKey,
                                orderType: orderKey,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Wrap the search field in a const to prevent unnecessary rebuilds
                  CustomTextFormFieldWidget(
                    keyboardType: TextInputType.text,
                    controller: searchController,
                    hintText: S.of(context).searchHint,
                    labelText: S.of(context).searchLabel,
                    obscureText: false,
                    suffixIconOnPressed: () {},
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return S.of(context).searchValidation;
                      }
                      return null;
                    },
                    onChanged: (value) async {
                      if (selectedType == 'Products') {
                        await cubit.getProductSearch(
                          name: searchController.text,
                          sortType: selectedSort ==
                                  S.of(context).searchSortProductsByDefault
                              ? 'id'
                              : selectedSort ==
                                      S.of(context).searchSortProductsByPrice
                                  ? 'new-price'
                                  : 'name',
                          orderType:
                              selectedOrder == S.of(context).searchOrderByAsc
                                  ? 'asc'
                                  : 'desc',
                        );
                      } else if (selectedType == 'Categories') {
                        await cubit.getCategorySearch(
                          name: searchController.text,
                          sortType: selectedSort ==
                                  S.of(context).searchSortCategoriesByDefault
                              ? 'id'
                              : 'name',
                          orderType:
                              selectedOrder == S.of(context).searchOrderByAsc
                                  ? 'asc'
                                  : 'desc',
                        );
                      }
                    },
                    onFieldSubmitted: (value) async {
                      if (selectedType == 'Products') {
                        await cubit.getProductSearch(
                          name: searchController.text,
                          sortType: selectedSort ==
                                  S.of(context).searchSortProductsByDefault
                              ? 'id'
                              : selectedSort ==
                                      S.of(context).searchSortProductsByPrice
                                  ? 'new-price'
                                  : 'name',
                          orderType:
                              selectedOrder == S.of(context).searchOrderByAsc
                                  ? 'asc'
                                  : 'desc',
                        );
                      } else if (selectedType == 'Categories') {
                        await cubit.getCategorySearch(
                          name: searchController.text,
                          sortType: selectedSort ==
                                  S.of(context).searchSortCategoriesByDefault
                              ? 'id'
                              : 'name',
                          orderType:
                              selectedOrder == S.of(context).searchOrderByAsc
                                  ? 'asc'
                                  : 'desc',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),

                  // Using BlocBuilder for SearchItemsList widget
                  SearchItemsList(
                    selectedType: selectedType,
                    searchOrder: selectedOrder,
                    searchSort: selectedSort,
                    cubit: cubit,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChoiceChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    return ChoiceChip(
      showCheckmark: false,
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      avatar: Icon(
        icon,
        color: isSelected ? Colors.white : primaryColor,
        size: 18,
      ),
      selected: isSelected,
      selectedColor: primaryColor,
      backgroundColor: Colors.transparent,
      shape: StadiumBorder(
        side: BorderSide(color: primaryColor),
      ),
      onSelected: (_) => onSelected(),
      /// A styled [DropdownButton] widget with a white background, primary color
      /// border, and a 24px rounded rectangle shape.
      ///
      /// [value] is the currently selected item.
      ///
      /// [items] are the items to be displayed in the dropdown.
      ///
      /// [onChanged] is called when the user selects an item.
      ///
    );
  }

  Widget _buildStyledDropdown<T>({
    required BuildContext context,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
          icon: const Icon(Icons.arrow_drop_down),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

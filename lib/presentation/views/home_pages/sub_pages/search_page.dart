import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/search_widgets/list_view_search_categories_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/search_widgets/list_view_search_product_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selectedType = 'Products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            popNavigator(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
        title: Text(
          'Search',
          style: TextStyles.appBarTitle,
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = AppCubit.get(context);

            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: Text('Products'),
                          selected: selectedType == 'Products',
                          selectedColor: primaryColor,
                          onSelected: (_) {
                            setState(() => selectedType = 'Products');
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: Text('Categories'),
                          selected: selectedType == 'Categories',
                          selectedColor: primaryColor,
                          onSelected: (_) {
                            setState(() => selectedType = 'Categories');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormFieldWidget(
                      controller: searchController,
                      hintText: 'Search $selectedType',
                      labelText: 'Search',
                      obscureText: false,
                      suffixIconOnPressed: () {},
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please enter $selectedType name';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          if (selectedType == 'Products') {
                            cubit.getProductSearch(name: value);
                            setState(() {});
                          }

                          if (selectedType == 'Categories') {
                            cubit.getCategorySearch(name: value);
                            setState(() {});
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Builder(builder: (context) {
                        final isProduct = selectedType == 'Products';
                        final hasResults = isProduct
                            ? (cubit.productSearchModel?.data?.isNotEmpty ??
                                false)
                            : (cubit.categorySearchModel?.data?.isNotEmpty ??
                                false);
                        if (!hasResults) {
                          return Text(
                            'No ${selectedType.toLowerCase()} found with that name.',
                            style: TextStyles.productTitle.copyWith(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: selectedType == 'Products'
                              ? cubit.productSearchModel?.data?.length ?? 0
                              : cubit.categorySearchModel?.data?.length ?? 0,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (selectedType == 'Products') {
                              return ListViewSearchProductWidget(
                                  cubit: cubit, index: index);
                            }

                            if (selectedType == 'Categories') {
                              return ListViewSearchCategoriesWidget(
                                  cubit: cubit, index: index);
                            } else {
                              return Text(
                                'Search for $selectedType',
                                style: TextStyles.productTitle.copyWith(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              );
                            }
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

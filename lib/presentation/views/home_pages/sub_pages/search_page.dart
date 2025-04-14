import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
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
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: Text('Products'),
                        selected: selectedType == 'Products',
                        selectedColor: primaryColor,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => selectedType = 'Products');
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: Text('Categories'),
                        selected: selectedType == 'Categories',
                        selectedColor: primaryColor,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => selectedType = 'Categories');
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Wrap the search field in a const to prevent unnecessary rebuilds
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
                    onFieldSubmitted: (value) async {
                      if (formKey.currentState!.validate()) {
                        // Show loading dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          ),
                        );

                        try {
                          // Await the search operation
                          if (selectedType == 'Products') {
                            await cubit.getProductSearch(name: value);
                          } else if (selectedType == 'Categories') {
                            await cubit.getCategorySearch(name: value);
                          }
                        } finally {
                          // Always close the dialog
                          if (context.mounted) Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 10),

                  // Using BlocBuilder for SearchItemsList widget
                  SearchItemsList(selectedType: selectedType, cubit: cubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

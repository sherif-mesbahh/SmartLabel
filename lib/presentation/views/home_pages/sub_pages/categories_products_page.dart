import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/custom_app_bar.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/grid_view_item.dart';

class CategoriesProductsPage extends StatelessWidget {
  const CategoriesProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Label',
          style: TextStyles.appBarTitle,
        ),
        backgroundColor: primaryColor,
        leading: Image(
          image: AssetImage(
            'assets/images/smart_label_logo.png',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              popNavigator(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: secondaryColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          final products = cubit.categoryProductsModel!.data?.products;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  if (state is GetProductsLoadingState)
                    const Center(child: CircularProgressIndicator())
                  else if (products == null)
                    const Center(child: Text('Loading...'))
                  else if (products.isEmpty)
                    const Center(child: Text('No Products Found'))
                  else ...[
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GridViewItem(model: products[index]);
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

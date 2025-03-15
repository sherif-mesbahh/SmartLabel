import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/edit_product_description_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/edit_product_image_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/edit_product_name_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/edit_product_price_dialog_widget.dart';

class AdminEditProductPage extends StatelessWidget {
  const AdminEditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Text(
              'Edit Product',
              style: TextStyles.appBarTitle,
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Product Name', style: TextStyles.headline2),
                      Spacer(),
                      TextButton(
                        child: Text(
                          'Edit Name',
                          style: TextStyles.productTitle
                              .copyWith(color: primaryColor),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditProductNameDialogWidget(
                              productId: 1,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image(
                        height: screenHeight(context) * .15,
                        width: screenWidth(context) * .3,
                        image: AssetImage(
                          'assets/images/fruits_image.jpg',
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditProductImageDialogWidget(
                              productId: 1,
                            ),
                          );
                        },
                        child: Text(
                          'Edit Image',
                          style: TextStyles.productTitle
                              .copyWith(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Price: ',
                        style: TextStyles.productPrice.copyWith(
                          fontSize: 18,
                          color: darkColor,
                        ),
                      ),
                      Text('Product Price', style: TextStyles.headline2),
                      Spacer(),
                      TextButton(
                        child: Text(
                          'Edit Price',
                          style: TextStyles.productTitle
                              .copyWith(color: primaryColor),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditProductPriceDialogWidget(
                              productId: 1,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Description:', style: TextStyles.headline2),
                      Spacer(),
                      TextButton(
                        child: Text(
                          'Edit Description',
                          style: TextStyles.productTitle
                              .copyWith(color: primaryColor),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                EditProductDescriptionDialogWidget(
                              productId: 1,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Product Description',
                    style: TextStyles.description,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

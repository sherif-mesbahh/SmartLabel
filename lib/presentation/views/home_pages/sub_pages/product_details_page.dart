import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_images_indicator_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_images_page_view_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/product_details_widgets/product_details_price_row_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Image(
              height: 50,
              image: AssetImage(
                'assets/images/smart_label_logo.png',
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Smart Label',
              style: TextStyles.appBarTitle,
            ),
          ],
        ),
      ),
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Name',
                style: TextStyles.headline2,
              ),
              ProductImagesPageView(pageController: pageController),
              SizedBox(height: 10),
              ProductDetailsImagesIndicator(pageController: pageController),
              SizedBox(height: 10),
              ProductDetailsPriceRow(),
              SizedBox(height: 10),
              Text(
                'Description: ',
                style: TextStyles.description.copyWith(
                  fontSize: 18,
                  color: darkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'sdfsdafasdfsdfsdfdsfsdfsdfsdfsdfdsfssdfsdfsdfdsfsdsdfsdfsdfdsfsdsdfsdfsdfdsfsdsdfsdfsdfdsfsdsdfsdfsdfdsfsdsdfsdfsdfdsfsdd',
                style: TextStyles.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/models/category_products_model/category_products_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_category_details_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_details_widgets/edit_category_image_dialog.dart';

class AdminCategoryDetailsEditImageWidget extends StatelessWidget {
  const AdminCategoryDetailsEditImageWidget({
    super.key,
    required this.cubit,
    required this.category,
  });

  final AppCubit cubit;
  final CategoryProductsDataModel? category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        cubit.mainCategoryImageToUpload != null
            ? Image.file(
                File(cubit.mainCategoryImageToUpload!.path),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )
            : cubit.categoryProductsModel!.data?.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl:
                        'http://smartlabel1.runasp.net/Uploads/${cubit.categoryProductsModel!.data?.imageUrl}',
                    height: screenHeight(context) * .15,
                    width: screenWidth(context) * .3,
                    placeholder: (context, url) => Center(
                      child: Lottie.asset(
                        'assets/lottie/loading_indicator.json',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 30),
                  ),
        Spacer(),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => EditCategoryImageDialog(
                categoryId: category!.id!,
                categoryProductsDataModel: category!,
              ),
            );
          },
          child: Text(
            'Edit Image',
            style: TextStyles.productTitle.copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/full_screen_image.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/category_products_model/category_products_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
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
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullScreenImagePage(
                            imageUrl: Uri.encodeFull(
                                'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(cubit.categoryProductsModel!.data?.imageUrl ?? '')}'),
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: Uri.encodeFull(
                          'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(cubit.categoryProductsModel!.data?.imageUrl ?? '')}'),
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
                    ),
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
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(primaryColor.withOpacity(0.25)),
            foregroundColor: WidgetStateProperty.all(primaryColor),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: primaryColor.withOpacity(0.4)),
              ),
            ),
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return primaryColor.withOpacity(0.2);
                }
                if (states.contains(WidgetState.hovered)) {
                  return primaryColor.withOpacity(0.15);
                }
                return null;
              },
            ),
            textStyle: WidgetStateProperty.all(
              TextStyles.productTitle(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child: Text(S.of(context).editCategoryEditImageButton),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/product_details_model/product_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/product_details_widgets/admin_product_details_add_images_dialog_widget.dart';

class ProductDetailsAddImagesWidget extends StatelessWidget {
  const ProductDetailsAddImagesWidget({
    super.key,
    required this.cubit,
    required this.product,
  });

  final AppCubit cubit;
  final ProductDetailsDataModel? product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cubit.productImagesToUpload.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cubit.productImagesToUpload
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final image = entry.value;

                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(image.path),
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: IconButton(
                              icon: const Icon(Icons.cancel,
                                  color: Colors.red, size: 18),
                              onPressed: () {
                                cubit.productImagesToUpload.removeAt(index);
                                (context as Element).markNeedsBuild();
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 12.0),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddProductDetailsImagesDialogWidget(
                      productId: product!.id!,
                      productDetailsDataModel: product!,
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    primaryColor.withOpacity(0.25),
                  ),
                  foregroundColor: WidgetStateProperty.all(primaryColor),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                child: Text(S.of(context).editProductAddImagesButton),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

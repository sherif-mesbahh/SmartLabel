import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/full_screen_image.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/product_details_widgets/admin_product_details_main_image_dialog_widget.dart';

class ProductDetailsMainImageWidget extends StatelessWidget {
  const ProductDetailsMainImageWidget({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: cubit.mainproductImageToUpload != null
              ? Image.file(
                  File(cubit.mainproductImageToUpload!.path),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )
              : cubit.productDetailsModel!.data?.mainImage != null
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullScreenImagePage(
                              imageUrl:
                                  "http://smartlabel1.runasp.net/Uploads/${cubit.productDetailsModel!.data!.mainImage}",
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://smartlabel1.runasp.net/Uploads/${cubit.productDetailsModel!.data!.mainImage}",
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          height: 80,
                          width: 80,
                          child: Center(
                            child: Lottie.asset(
                              'assets/lottie/loading_indicator.json',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 80,
                          width: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    )
                  : Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 30),
                    ),
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => AddMainProductImageDialogWidget(),
            );
          },
          child: Text(
            S. of(context).editProductEditMainImageButton,
            style:
                TextStyles.productTitle(context).copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }
}

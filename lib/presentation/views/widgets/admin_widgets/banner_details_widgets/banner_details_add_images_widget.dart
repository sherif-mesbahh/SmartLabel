import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/add_banner_details_images_dialog_widget.dart';

class BannerDetailsAddImagesWidget extends StatelessWidget {
  const BannerDetailsAddImagesWidget({
    super.key,
    required this.cubit,
    required this.banner,
  });

  final AppCubit cubit;
  final BannerDetailsDataModel? banner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (cubit.bannerDetailsImagesToUpload.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cubit.bannerDetailsImagesToUpload
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
                                cubit.bannerDetailsImagesToUpload
                                    .removeAt(index);
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
                child: Text(
                  S.of(context).editBannerAddImagesButton,
                  style: TextStyles.productTitle(context)
                      .copyWith(color: primaryColor),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddBannerDetailsImagesDialogWidget(
                      bannerId: banner!.id!,
                      bannerDetailsDataModel: banner!,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

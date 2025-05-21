import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/full_screen_image.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_data_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/banner_details_widgets/change_banner_details_main_image_dialog.dart';

class BannerDetailsMainImageRowWidget extends StatelessWidget {
  const BannerDetailsMainImageRowWidget({
    super.key,
    required this.cubit,
    required this.banner,
  });

  final AppCubit cubit;
  final BannerDetailsDataModel? banner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: cubit.mainBannerImageToUpload != null
              ? Image.file(
                  File(cubit.mainBannerImageToUpload!.path),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )
              : cubit.bannerDetailsModel!.data?.mainImage != null
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullScreenImagePage(
                              imageUrl: Uri.encodeFull(
                                  'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(cubit.bannerDetailsModel!.data!.mainImage ?? '')}'),
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: Uri.encodeFull(
                            'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(cubit.bannerDetailsModel!.data!.mainImage ?? '')}'),
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
              builder: (context) => AddMainBannerImageDialogWidget(),
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
          child: Text(S.of(context).editBannerMainImageButton),
        ),
      ],
    );
  }
}

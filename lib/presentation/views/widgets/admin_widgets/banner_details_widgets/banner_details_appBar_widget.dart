import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';

class AdminBannerDetailsAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AdminBannerDetailsAppBarWidget({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        'Banner Details',
        style: TextStyles.appBarTitle,
      ),
      leading: IconButton(
        onPressed: () {
          cubit.bannerDetailsImagesToUpload = [];
          cubit.bannerDetailsImagesToDelete = [];
          cubit.mainBannerImageToUpload = null;
          popNavigator(context);
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: secondaryColor,
          size: 30,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

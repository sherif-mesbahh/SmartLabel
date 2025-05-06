import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class ActiveBannerDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ActiveBannerDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        'Banner Details',
        style: TextStyles.appBarTitle(context),
      ),
      leading: IconButton(
        onPressed: () => popNavigator(context),
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

import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/search_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Smart Label',
        style: TextStyles.appBarTitle,
      ),
      backgroundColor: primaryColor,
      leading: Image(
        image: AssetImage(
          'assets/images/smart_label_logo.png',
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            pushNavigator(context, SearchPage(), slideBottomToTop);
          },
          icon: Icon(
            Icons.search,
            color: secondaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

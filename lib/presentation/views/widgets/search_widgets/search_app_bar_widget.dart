import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          popNavigator(context);
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: secondaryColor,
          size: 30,
        ),
      ),
      title: Text(
        'Search',
        style: TextStyles.appBarTitle,
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
    );
  }
}

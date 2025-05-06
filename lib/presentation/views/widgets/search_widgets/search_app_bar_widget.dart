import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (AppCubit.get(context).navBarCurrentIndex == 0) {
            AppCubit.get(context).getProducts();
            AppCubit.get(context).getActiveBanners();
          }
          if (AppCubit.get(context).navBarCurrentIndex == 2) {
            AppCubit.get(context).getFav();
          }
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
        style: TextStyles.appBarTitle(context),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
    );
  }
}

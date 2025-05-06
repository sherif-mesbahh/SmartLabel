import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';

class AdminCategoryDetailsAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AdminCategoryDetailsAppBarWidget({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leading: IconButton(
        onPressed: () {
          cubit.mainCategoryImageToUpload = null;
          popNavigator(context);
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: secondaryColor,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: Text(
        'Edit Category',
        style: TextStyles.appBarTitle(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

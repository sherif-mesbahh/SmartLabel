import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_categories_page.dart';

class AdminPanelWidget extends StatelessWidget {
  const AdminPanelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Admin Panel',
              style: TextStyles.cartItemTitle(context)),
          IconButton(
            color: primaryColor,
            iconSize: 30,
            onPressed: () {
              AppCubit.get(context).isAdminPanelLoading = true;
              AppCubit.get(context)
                  .getBanners()
                  .then((onValue) {
                AppCubit.get(context)
                    .getCategories()
                    .then((onValue) {
                  AppCubit.get(context).isAdminPanelLoading =
                      false;
                  pushNavigator(context, AdminCategoriesPage(),
                      fadeTransition);
                });
              });
            },
            icon: Icon(
              Icons.admin_panel_settings,
            ),
          ),
        ],
      ),
    );
  }
}


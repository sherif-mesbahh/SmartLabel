import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
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
          Text(S.of(context).profilePageAdminPanel,
              style: TextStyles.cartItemTitle(context)),
          BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return IconButton(
                color: primaryColor,
                iconSize: 30,
                onPressed: () async {
                  final cubit = AppCubit.get(context);
                  final navigator = Navigator.of(context);

                  cubit.isAdminPanelLoading = true;
                  await cubit.getBanners();
                  await cubit.getCategories();
                  await cubit.getAllUsers();
                  cubit.isAdminPanelLoading = false;

                  if (navigator.mounted) {
                    try {
                      navigator.push(fadeTransition(AdminCategoriesPage()));
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                },
                icon: Icon(
                  Icons.admin_panel_settings,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

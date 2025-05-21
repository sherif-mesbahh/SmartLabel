import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_categories_page.dart';

class AdminPanelWidget extends StatelessWidget {
  const AdminPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).profilePageAdminPanel,
            style: TextStyles.cartItemTitle(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
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
                  icon: const Icon(Icons.admin_panel_settings),
                  label: Text(S.of(context).goToAdminPanel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

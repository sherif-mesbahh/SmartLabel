import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_admin_panel_row_widget.dart';

class LayoutDrawerWidget extends StatelessWidget {
  const LayoutDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<AppCubit>().themeMode == ThemeMode.dark;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                S.of(context).profilePageSideMenuTitle,
                style: TextStyles.headline1(context),
              ),
            ),
            const Divider(),

            // Dark Mode Toggle
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.dark_mode, color: primaryColor),
                title: Text(
                  S.of(context).profilePageSideMenuDarkMode,
                  style: TextStyles.cartItemTitle(context),
                ),
                trailing: CupertinoSwitch(
                  value: isDarkMode,
                  activeTrackColor: primaryColor,
                  onChanged: (val) {
                    context.read<AppCubit>().toggleTheme(val);
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Admin Panel (if admin)

            if (AppCubit.get(context).isLogin &&
                AppCubit.get(context)
                        .userInfoModel
                        ?.data
                        ?.roles
                        ?.contains('Admin') ==
                    true)
              Card(
                color: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AdminPanelWidget(),
              ),

            const SizedBox(height: 16),

            // Change Language
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.language, color: primaryColor),
                title: Text(
                  S.of(context).profilePageSideMenuChangeLanguageTitle,
                  style: TextStyles.cartItemTitle(context),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(S
                          .of(context)
                          .profilePageSideMenuChangeLanguageDialogTitle),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(S
                                .of(context)
                                .profilePageSideMenuChangeLanguageDialogEnglish),
                            onTap: () {
                              context.read<AppCubit>().toggleLanguage(false);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(S
                                .of(context)
                                .profilePageSideMenuChangeLanguageDialogArabic),
                            onTap: () {
                              context.read<AppCubit>().toggleLanguage(true);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // About Us
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.info_outline, color: primaryColor),
                title: Text(
                  S.of(context).profilePageSideMenuAboutUsTitle,
                  style: TextStyles.cartItemTitle(context),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                          S.of(context).profilePageSideMenuAboutUsDialogTitle),
                      content: Text(
                        S.of(context).profilePageSideMenuAboutUsDialogText,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(S
                              .of(context)
                              .profilePageSideMenuAboutUsDialogButton),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

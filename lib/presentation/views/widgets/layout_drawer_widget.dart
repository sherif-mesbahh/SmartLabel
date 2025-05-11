import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';

class LayoutDrawerWidget extends StatelessWidget {
  const LayoutDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).profilePageSideMenuTitle,
                  style: TextStyles.headline1(context)),
              const SizedBox(height: 24),

              // Dark Mode Toggle
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Row(
                  children: [
                    Text(
                      S.of(context).profilePageSideMenuDarkMode,
                      style: TextStyles.cartItemTitle(context),
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      value:
                          context.read<AppCubit>().themeMode == ThemeMode.dark,
                      activeTrackColor: primaryColor,
                      onChanged: (val) {
                        context.read<AppCubit>().toggleTheme(val);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 32),

              // Change Language
              ListTile(
                leading: Icon(Icons.language, color: primaryColor),
                title: Text(
                    S.of(context).profilePageSideMenuChangeLanguageTitle,
                    style: TextStyles.cartItemTitle(context)),
                onTap: () {
                  Navigator.pop(context);
                  // Add your language picker logic here
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
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(S
                                .of(context)
                                .profilePageSideMenuChangeLanguageDialogArabic),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Divider(height: 16),

              // About Us
              ListTile(
                leading: Icon(Icons.info_outline, color: primaryColor),
                title: Text(S.of(context).profilePageSideMenuAboutUsTitle,
                    style: TextStyles.cartItemTitle(context)),
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
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
              Text('Settings', style: TextStyles.headline1(context)),
              const SizedBox(height: 24),

              // Dark Mode Toggle
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Row(
                  children: [
                    Text(
                      'Dark Mode',
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
                title: Text('Change Language',
                    style: TextStyles.cartItemTitle(context)),
                onTap: () {
                  Navigator.pop(context);
                  // Add your language picker logic here
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Select Language'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('English'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('Arabic'),
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
                title:
                    Text('About Us', style: TextStyles.cartItemTitle(context)),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('About Us'),
                      content: const Text(
                        'Smart Label is a next-gen pricing and inventory platform for retailers.\n\nVersion: 1.0.0\n© 2025 Smart Label Inc.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
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

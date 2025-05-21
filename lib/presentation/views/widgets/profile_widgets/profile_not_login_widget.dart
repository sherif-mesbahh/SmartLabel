import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/login_page.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_up_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_settengs_row_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class NotLoginWidget extends StatelessWidget {
  const NotLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).profilePageTitle,
              style: TextStyles.headline1(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Settings

            Card(
              elevation: 2,
              color: isDark ? Colors.grey[850] : Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SettingsWidget(),
              ),
            ),

            const SizedBox(height: 12),

            // Sign In / Sign Up
            CustomButtonWidget(
              onTap: () {
                pushNavigator(context, LoginPage(), fadeTransition);
                AppCubit.get(context).navBarCurrentIndex = 0;
              },
              color: primaryColor,
              child: Center(
                child: Text(
                  S.of(context).profilePageSignInButton,
                  style: TextStyles.buttonText(context),
                ),
              ),
            ),
            const SizedBox(height: 12),
            CustomButtonWidget(
              onTap: () {
                pushNavigator(context, SignUpPage(), fadeTransition);
                AppCubit.get(context).navBarCurrentIndex = 0;
              },
              color: primaryColor.withOpacity(0.9),
              child: Center(
                child: Text(
                  S.of(context).profilePageSingUpButton,
                  style: TextStyles.buttonText(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

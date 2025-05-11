import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Text(
            S.of(context).profilePageSettings,
            style: TextStyles.cartItemTitle(context),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .scaffoldKey
                  ?.currentState
                  ?.openEndDrawer();
            },
            icon: Icon(
              Icons.settings,
              color: primaryColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class ForgotPasswordAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ForgotPasswordAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        S.of(context).forgotPasswordTitle,
        style: TextStyles.appBarTitle(context),
      ),
      leading: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              popNavigator(context);
              AppCubit.get(context).codeSent = false;
              AppCubit.get(context).codeVerified = false;
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: secondaryColor,
              size: 30,
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

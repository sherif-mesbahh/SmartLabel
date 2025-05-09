import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/login_page.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_up_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class NotLoginWidget extends StatelessWidget {
  const NotLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
        const SizedBox(height: 12),
        CustomButtonWidget(
          onTap: () {
            pushNavigator(context, LoginPage(), fadeTransition);
            AppCubit.get(context).navBarCurrentIndex = 0;
          },
          color: primaryColor,
          child: Text(
            'Sign In',
            style: TextStyles.buttonText(context),
          ),
        ),
        const SizedBox(height: 12),
        CustomButtonWidget(
          onTap: () {
            pushNavigator(context, SignUpPage(), fadeTransition);
            AppCubit.get(context).navBarCurrentIndex = 0;
          },
          color: primaryColor,
          child: Text(
            'Sign Up',
            style: TextStyles.buttonText(context),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Profile', style: TextStyles.headline1),
              const Spacer(),
              CustomButtonWidget(
                onTap: () {
                  AppCubit.get(context).logout().then((onValue) {
                    navigatorAndRemove(context, SignPage(), fadeTransition);
                  });
                },
                color: primaryColor,
                child: Text(
                  'Sign out',
                  style: TextStyles.buttonText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

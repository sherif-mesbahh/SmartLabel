import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/notificatioons_page.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/search_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Smart Label',
        style: TextStyles.appBarTitle(context),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
      leading: Image(
        image: AssetImage(
          'assets/images/smart_label_logo.png',
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            pushNavigator(context, SearchPage(), slideBottomToTop);
          },
          icon: Icon(
            Icons.search,
            color: secondaryColor,
            size: 30,
          ),
        ),
        BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                pushNavigator(context, NotificatioonsPage(), slideBottomToTop);
                AppCubit.get(context).notificatinIconPath =
                    'assets/images/notification.png';
              },
              icon: Image(
                height: 30,
                image: AssetImage(
                  AppCubit.get(context).notificatinIconPath,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

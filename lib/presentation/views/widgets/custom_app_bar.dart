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
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              onPressed: () {
                pushNavigator(context, NotificatioonsPage(), slideBottomToTop);
              },
              icon: Image(
                height: 30,
                image: AssetImage(
                  'assets/images/notification.png',
                ),
              ),
            ),
            BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                final unread =
                    context.watch<AppCubit>().unreadNotificationCount;

                if (unread == 0) return const SizedBox.shrink();

                return Positioned(
                  top: 6,
                  right: 6,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$unread',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

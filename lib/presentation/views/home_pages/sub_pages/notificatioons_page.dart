import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/themes/themes.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/notification_widgets/notification_item_widget.dart';

class NotificatioonsPage extends StatefulWidget {
  const NotificatioonsPage({super.key});

  @override
  State<NotificatioonsPage> createState() => _NotificatioonsPageState();
}

class _NotificatioonsPageState extends State<NotificatioonsPage> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          S.of(context).notifications,
          style: TextStyles.appBarTitle(context),
        ),
        leading: IconButton(
          onPressed: () => popNavigator(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);

          if (!cubit.isLogin) {
            return Center(
                child: Text(S.of(context).youMustBeLoggedIn,
                    style: TextStyle(color: Colors.red)));
          }

          if (state is GetNotificationsLoadingState) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/loading_indicator.json',
                width: 100,
                height: 100,
              ),
            );
          }

          if (state is GetNotificationsErrorState) {
            return Center(
              child: Text(
                S.of(context).failedToLoadNotifications,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is GetNotificationsSuccessState ||
              cubit.notificationsModel != null) {
            final notifications = cubit.notificationsModel?.data ?? [];

            notifications.sort((a, b) {
              final aDate =
                  a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
              final bDate =
                  b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
              return bDate.compareTo(aDate); // Sort newest to oldest
            });

            if (notifications.isEmpty) {
              return Center(
                child: Text(
                  S.of(context).noNotificationsFound,
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItem(
                  message: notification.message,
                  createdAt: notification.createdAt,
                  id: notification.id,
                );
              },
            );
          }

          return const SizedBox(); // Fallback
        },
      ),
    );
  }
}

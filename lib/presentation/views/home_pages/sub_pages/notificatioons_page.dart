import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/themes/themes.dart';
import 'package:smart_label_software_engineering/core/utils/shimmer_notification_item.dart';
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
          onPressed: () => Navigator.pop(context),
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
              child: Text(
                S.of(context).youMustBeLoggedIn,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is GetNotificationsLoadingState) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (_, __) => const ShimmerNotificationItem(),
            );
          }

          if (state is GetNotificationsErrorState ||
              cubit.notificationsModel?.data == null) {
            return Center(
              child: Text(
                S.of(context).failedToLoadNotifications,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final notifications = cubit.notificationsModel!.data!;

          notifications.sort((a, b) {
            final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bDate.compareTo(aDate);
          });

          if (notifications.isEmpty) {
            return Center(
              child: Text(
                S.of(context).noNotificationsFound,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await Future.wait([cubit.getNotifications()]);
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final n = notifications[index];
                return NotificationItem(
                    id: n.id,
                    message: n.message,
                    createdAt: n.createdAt,
                    image: n.image,
                    isRead: n.isRead // ✅ image support if provided
                    );
              },
            ),
          );
        },
      ),
    );
  }
}

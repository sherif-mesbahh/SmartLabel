import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/themes/themes.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/active_banner_details_page.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/product_details_page.dart';

class NotificationItem extends StatelessWidget {
  final String? message;
  final DateTime? createdAt;
  final int? id;
  final String? image;
  final bool? isRead;

  const NotificationItem({
    super.key,
    this.message,
    this.createdAt,
    this.id,
    this.image,
    this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = createdAt != null
        ? DateFormat('yyyy-MM-dd – hh:mm a').format(createdAt!)
        : 'Unknown date';

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            if (id == null) {
              Fluttertoast.showToast(
                msg: (S.of(context).invalidNotification),
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16,
              );
              return;
            }

            await AppCubit.get(context)
                .getNotificationDetails(id: id!)
                .then((_) async {
              final notificationData =
                  AppCubit.get(context).notificationDetailsModel?.data;

              if (notificationData == null || notificationData.typeId == null) {
                Fluttertoast.showToast(
                  msg: (S.of(context).invalidNotificationDetails),
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  fontSize: 16,
                );
                return;
              }

              final typeId = notificationData.typeId!;
              final type = notificationData.type;

              if (type == 1) {
                await AppCubit.get(context)
                    .getProductDetails(id: typeId)
                    .then((_) {
                  final product =
                      AppCubit.get(context).productDetailsModel?.data;
                  if (product != null && product.categoryId != null) {
                    pushNavigator(
                      context,
                      ProductDetailsPage(categoryId: product.categoryId!),
                      slideRightToLeft,
                    );
                    if (isRead == false) {
                      AppCubit.get(context).seenNotification(id: id!);
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: (S.of(context).productDetailsNotFound),
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16,
                    );
                  }
                });
              } else if (type == 2) {
                await AppCubit.get(context)
                    .getActiveBannerDetails(id: typeId)
                    .then((_) {
                  final bannerData =
                      AppCubit.get(context).activeBannerDetailsModel?.data;

                  if (bannerData != null && bannerData.id != null) {
                    pushNavigator(
                      context,
                      ActiveBannerDetailsPage(
                        key: UniqueKey(),
                        id: typeId,
                      ),
                      slideRightToLeft,
                    );
                    if (isRead == false) {
                      AppCubit.get(context).seenNotification(id: id!);
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: (S.of(context).bannerDetailsNotFound),
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16,
                    );
                  }
                });
              } else {
                Fluttertoast.showToast(
                  msg: (S.of(context).unknownNotificationTybe),
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  fontSize: 16,
                );
              }
            });
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 10,
            color: isRead == true ? Colors.grey : primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: Uri.encodeFull(
                            'http://smartlabel1.runasp.net/Uploads/${Uri.encodeComponent(image ?? '')}'),
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : const Icon(Icons.notifications, color: Colors.blue),
              title: Text(
                message ?? 'No message',
                style: TextStyles.productTitle(context).copyWith(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                formattedDate,
                style: TextStyles.productTitle(context).copyWith(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

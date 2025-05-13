import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/user_details_row_widget.dart';

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserDetailsRowWidget(
              title: S.of(context).profilePageUserInfoFirstName,
              value:
                  AppCubit.get(context).userInfoModel?.data?.firstName ?? ''),
          const SizedBox(height: 12),
          UserDetailsRowWidget(
            title: S.of(context).profilePageUserInfoLastName,
            value: AppCubit.get(context).userInfoModel!.data?.lastName ?? '',
          ),
          const SizedBox(height: 12),
          UserDetailsRowWidget(
            title: S.of(context).profilePageUserInfoEmail,
            value: AppCubit.get(context).userInfoModel!.data?.email ?? '',
          ),
        ],
      ),
    );
  }
}

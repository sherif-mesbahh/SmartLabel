import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_admin_panel_row_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_delete_account_and_change_password_row_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_edit_info_button_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_not_login_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_settengs_row_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profle_info_card_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        if (AppCubit.get(context).isLogin) {
          if (AppCubit.get(context).isAdminPanelLoading) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/loading_indicator.json',
                width: 100,
                height: 100,
              ),
            );
          }
          if (state is GetUserInfoLoadingState) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/loading_indicator.json',
                width: 100,
                height: 100,
              ),
            );
          }

          if (state is GetUserInfoErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).profilePageTitle,
                    style: TextStyles.headline1(context)),
                const SizedBox(height: 12),
                Text(S.of(context).failedToLoadUserInfo),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SettingsWidget(),
                ),
                const SizedBox(height: 12),
                CustomButtonWidget(
                  onTap: () {
                    AppCubit.get(context).logout().then((onValue) {
                      pushNavigator(context, SignPage(), fadeTransition);
                    });
                  },
                  color: primaryColor,
                  child: Text(
                    S.of(context).profilePageSingOutButton,
                    style: TextStyles.buttonText(context),
                  ),
                )
              ],
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(S.of(context).profilePageTitle,
                      style: TextStyles.headline1(context)),
                  // Edit Profile Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: EditInfoButtonWidget(),
                  ),
                  // User Details
                  UserInformationWidget(),
                  SizedBox(height: 0),
                  ChangePasswordAndDeleleAccountWidget(),
                  if (AppCubit.get(context)
                      .userInfoModel!
                      .data!
                      .roles!
                      .contains('Admin'))
                    // Admin Panel
                    AdminPanelWidget(),

                  // Settings
                  SettingsWidget(),
                  SizedBox(
                    height: 12,
                  ),
                  // Sign out
                  CustomButtonWidget(
                    onTap: () {
                      AppCubit.get(context).logout().then((onValue) {
                        Fluttertoast.showToast(
                          msg: S.of(context).signOutSuccessfully,
                          backgroundColor: Colors.green,
                          textColor: secondaryColor,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG,
                          timeInSecForIosWeb: 1,
                          fontSize: 16,
                        );
                      });
                    },
                    color: primaryColor,
                    child: Text(
                      S.of(context).profilePageSingOutButton,
                      style: TextStyles.buttonText(context),
                    ),
                  ),
                ],
              ),
            ),
          );

          // Sign
        } else {
          return NotLoginWidget();
        }
      },
    );
  }
}

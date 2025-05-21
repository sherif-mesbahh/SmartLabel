import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_page.dart';
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
        final cubit = AppCubit.get(context);
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        if (AppCubit.get(context).isLogin) {
          if (cubit.isAdminPanelLoading || state is GetUserInfoLoadingState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(height: 24, width: 200, color: Colors.white),
                    const SizedBox(height: 16),
                    Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.white),
                    const SizedBox(height: 16),
                    Container(
                        height: 40,
                        width: double.infinity,
                        color: Colors.white),
                    const SizedBox(height: 16),
                    Container(
                        height: 40,
                        width: double.infinity,
                        color: Colors.white),
                  ],
                ),
              ),
            );
          }

          if (state is GetUserInfoErrorState || cubit.userInfoModel == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/failed_icon.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).failedToLoadUserInfo,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    SettingsWidget(),
                    const SizedBox(height: 16),
                    CustomButtonWidget(
                      onTap: () {
                        cubit.logout().then((_) {
                          pushNavigator(
                              context, const SignPage(), fadeTransition);
                        });
                      },
                      color: primaryColor,
                      child: Text(
                        S.of(context).profilePageSingOutButton,
                        style: TextStyles.buttonText(context),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Text(
                      S.of(context).profilePageTitle,
                      style: TextStyles.headline1(context),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Profile Info & Edit Button
                  const UserInformationWidget(),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: EditInfoButtonWidget(),
                  ),
                  const SizedBox(height: 8),
                  const ChangePasswordAndDeleleAccountWidget(),
                  const SizedBox(height: 8),
                  // Settings Section

                  Card(
                    elevation: 2,
                    color: isDark ? Colors.grey[850] : Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SettingsWidget(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Sign Out Button
                  Center(
                    child: CustomButtonWidget(
                      onTap: () {
                        AppCubit.get(context).logout().then((_) {
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
                  ),
                  const SizedBox(height: 16),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_categories_page.dart';
import 'package:smart_label_software_engineering/presentation/views/sign_pages/sign_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/user_details_row_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        if (AppCubit.get(context).isLogin) {
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
            return Center(
              child: Text(state.error, style: TextStyles.headline1),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Profile', style: TextStyles.headline1),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          title: 'First Name',
                          value: AppCubit.get(context)
                                  .userInfoModel!
                                  .data
                                  ?.firstName ??
                              ''),
                      const SizedBox(height: 12),
                      UserDetailsRowWidget(
                        title: 'Last Name',
                        value: AppCubit.get(context)
                                .userInfoModel!
                                .data
                                ?.lastName ??
                            '',
                      ),
                      const SizedBox(height: 12),
                      UserDetailsRowWidget(
                        title: 'Email',
                        value:
                            AppCubit.get(context).userInfoModel!.data?.email ??
                                '',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (AppCubit.get(context)
                    .userInfoModel!
                    .data!
                    .roles!
                    .contains('Admin'))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Admin Panel', style: TextStyles.cartItemTitle),
                        IconButton(
                          color: primaryColor,
                          iconSize: 30,
                          onPressed: () {
                            AppCubit.get(context).getBanners().then((onValue) {
                              AppCubit.get(context)
                                  .getCategories()
                                  .then((onValue) {
                                pushNavigator(context, AdminCategoriesPage(),
                                    fadeTransition);
                              });
                            });
                          },
                          icon: Icon(
                            Icons.admin_panel_settings,
                          ),
                        ),
                      ],
                    ),
                  ),
                CustomButtonWidget(
                  onTap: () {
                    AppCubit.get(context).logout().then((onValue) {
                      pushNavigator(context, SignPage(), fadeTransition);
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
        } else {
          return Column(
            children: [
              SizedBox(height: 20),
              CustomButtonWidget(
                onTap: () {
                  pushNavigator(context, SignPage(), fadeTransition);
                  AppCubit.get(context).navBarCurrentIndex = 0;
                },
                color: primaryColor,
                child: Text(
                  'Sign',
                  style: TextStyles.buttonText,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

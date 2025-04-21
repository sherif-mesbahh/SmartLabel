import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetUserInfoLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
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
                      value:
                          AppCubit.get(context).userInfoModel!.data?.lastName ??
                              '',
                    ),
                    const SizedBox(height: 12),
                    UserDetailsRowWidget(
                      title: 'Email',
                      value: AppCubit.get(context).userInfoModel!.data?.email ??
                          '',
                    ),
                  ],
                ),
              ),
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
                          AppCubit.get(context).getCategories().then((onValue) {
                            pushNavigator(
                                context, AdminCategoriesPage(), fadeTransition);
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

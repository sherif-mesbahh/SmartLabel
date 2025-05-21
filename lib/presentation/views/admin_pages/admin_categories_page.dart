import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_edit_users_page.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/layout.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_widgets/add_banners_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_widgets/add_new_category_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_widgets/admin_banners_custom_slider_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/category_widgets/admin_categetoies_section_widget.dart';

class AdminCategoriesPage extends StatelessWidget {
  AdminCategoriesPage({super.key});
  final TextEditingController categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is DeleteBannerSuccessState) {
          Fluttertoast.showToast(
            msg: S.of(context).bannerDeletedSuccessfully,
            backgroundColor: Colors.green,
            textColor: secondaryColor,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 1,
            fontSize: 16,
          );
        }
        if (state is DeleteBannerErrorState) {
          Fluttertoast.showToast(
            msg: S.of(context).errorDeletingBanner,
            backgroundColor: Colors.red,
            textColor: secondaryColor,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 1,
            fontSize: 16,
          );
        }
        if (state is DeleteCategorySuccessState) {
          Fluttertoast.showToast(
            msg: S.of(context).categoryDeletedSuccessfully,
            backgroundColor: Colors.green,
            textColor: secondaryColor,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 1,
            fontSize: 16,
          );
        }
        if (state is DeleteCategoryErrorState) {
          Fluttertoast.showToast(
            msg: S.of(context).errorDeletingCategory,
            backgroundColor: Colors.red,
            textColor: secondaryColor,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 1,
            fontSize: 16,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
              onPressed: () {
                AppCubit.get(context).getUserInfo().then((_) {
                  navigatorAndRemove(context, Layout(), scaleTransition);
                });
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: secondaryColor,
                size: 30,
              ),
            ),
            centerTitle: true,
            title: Text(
              S.of(context).adminPanel,
              style: TextStyles.appBarTitle(context),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                context,
                                title: S.of(context).banners,
                                count: AppCubit.get(context)
                                        .bannersModel
                                        ?.data
                                        ?.length ??
                                    0,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                context,
                                title: S.of(context).activeBanners,
                                count: AppCubit.get(context)
                                        .activeBannersModel
                                        ?.data
                                        ?.length ??
                                    0,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                context,
                                title: S.of(context).categories,
                                count: AppCubit.get(context)
                                        .categoryModel
                                        ?.data
                                        ?.length ??
                                    0,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                context,
                                title: S.of(context).products,
                                count: AppCubit.get(context)
                                        .productModel
                                        ?.data
                                        ?.length ??
                                    0,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                context,
                                title: S.of(context).users,
                                count: AppCubit.get(context)
                                        .allUsersModel
                                        ?.data
                                        ?.length ??
                                    0,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  pushNavigator(
                                    context,
                                    AdminEditUsersPage(),
                                    slideRightToLeft,
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      primaryColor.withOpacity(0.25)),
                                  foregroundColor:
                                      WidgetStateProperty.all(primaryColor),
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(vertical: 16)),
                                  minimumSize: WidgetStateProperty.all(
                                      const Size.fromHeight(48)),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: primaryColor.withOpacity(0.4)),
                                    ),
                                  ),
                                  overlayColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return primaryColor.withOpacity(0.2);
                                      }
                                      if (states
                                          .contains(WidgetState.hovered)) {
                                        return primaryColor.withOpacity(0.15);
                                      }
                                      return null;
                                    },
                                  ),
                                  textStyle: WidgetStateProperty.all(
                                    TextStyles.productTitle(context).copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                child: Text(S.of(context).editUsersButton),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Banners
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).allBanners,
                          style: TextStyles.headline2(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddBannersDialogWidget(),
                            );
                          },
                          icon: Icon(Icons.add, color: primaryColor),
                          label: Text(
                            S.of(context).addBannerButton,
                            style: TextStyles.productTitle(context).copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor.withOpacity(0.15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: primaryColor.withOpacity(0.4)),
                            ),
                            foregroundColor: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  AppCubit.get(context).bannersModel?.data?.isEmpty ?? false
                      ? Center(
                          child: Text(
                            S.of(context).thereIsNoBanners,
                            style: TextStyles.productTitle(context),
                          ),
                        )
                      : BlocListener<AppCubit, AppStates>(
                          listener: (context, state) {},
                          child: AdminBannersCustomSliderWidget(
                            cubit: AppCubit.get(context),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  // Categories
                  Row(
                    children: [
                      Text(
                        S.of(context).allCategories,
                        style: TextStyles.headline2(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // All Categories
                  AppCubit.get(context).categoryModel?.data?.isEmpty ?? false
                      ? Center(
                          child: Text(
                            S.of(context).thereIsNoCategories,
                            style: TextStyles.productTitle(context),
                          ),
                        )
                      : AdminCategoriesSectionWidget(),
                ],
              ),
            ),
          ),
          // Add Category
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.add,
              color: secondaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddNewCategoryDialog(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required int count,
    required Color color,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.productTitle(context).copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyles.headline2(context).copyWith(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

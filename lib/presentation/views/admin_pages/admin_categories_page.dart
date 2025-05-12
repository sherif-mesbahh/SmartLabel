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
            msg:S.of(context).categoryDeletedSuccessfully,
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
            msg:S.of(context).errorDeletingCategory,
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
                navigatorAndRemove(context, Layout(), scaleTransition);
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
                  // Banners
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).allBanners,
                        style: TextStyles.headline2(context),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          pushNavigator(
                            context,
                            AdminEditUsersPage(),
                            slideRightToLeft,
                          );
                        },
                        child: Text(
                          S.of(context).editUsersButton,
                          style: TextStyles.buttonText(context).copyWith(
                            color: primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
                  //Add Banner Button
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).allCategories,
                        style: TextStyles.headline2(context),
                      ),
                      Spacer(),
                      TextButton(
                        child: Text(
                          S.of(context).addBannerButton,
                          style: TextStyles.productTitle(context)
                              .copyWith(color: primaryColor),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AddBannersDialogWidget(),
                          );
                        },
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
                            'There is no Categories',
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
}

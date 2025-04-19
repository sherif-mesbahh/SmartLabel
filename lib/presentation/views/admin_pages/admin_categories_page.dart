import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/add_new_category_dialog_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/admin_categories_grid_view_item_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/admin_custom_slider_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/admin_widgets/add_banners_dialog_widget.dart';

class AdminCategoriesPage extends StatelessWidget {
  AdminCategoriesPage({super.key});
  final TextEditingController categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddBannerSuccessState) {
          Fluttertoast.showToast(
              msg: 'Banner added successfully.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is AddBannerErrorState) {
          Fluttertoast.showToast(
              msg: 'Error adding banner.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is DeleteBannerSuccessState) {
          Fluttertoast.showToast(
              msg: 'Banner deleted successfully.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is DeleteBannerErrorState) {
          Fluttertoast.showToast(
              msg: 'Error deleting banner.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Text(
              'Admin Panel',
              style: TextStyles.appBarTitle,
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCubit.get(context).bannersModel?.data?.isEmpty ?? false
                      ? SizedBox()
                      : BlocBuilder<AppCubit, AppStates>(
                          buildWhen: (previous, current) =>
                              current is DeleteBannerLoadingState ||
                              current is DeleteBannerSuccessState ||
                              current is DeleteBannerErrorState,
                          builder: (context, state) {
                            if (state is GetBannersLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: primaryColor),
                              );
                            }
                            if (state is GetBannersErrorState) {
                              return Center(
                                child: Text(state.error,
                                    style: TextStyles.headline1),
                              );
                            }
                            return AdminCustomSliderWidget(
                              cubit: AppCubit.get(context),
                            );
                          },
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'All Categories',
                        style: TextStyles.headline2,
                      ),
                      Spacer(),
                      TextButton(
                        child: Text(
                          'Add Banners',
                          style: TextStyles.productTitle
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
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 10, // Space between columns
                      mainAxisSpacing: 10, // Space between rows
                      childAspectRatio: 1, // Adjust for item aspect ratio
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return AdminCategoriesGridViewItem();
                    },
                  ),
                ],
              ),
            ),
          ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/sub_pages/categories_page.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/home_categories_list_view_item.dart';

class CategoriesSecion extends StatelessWidget {
  const CategoriesSecion({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final category = cubit.categoryModel?.data;

        if (category == null) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).homePageNewCategories,
                      style:
                          TextStyles.headline2(context).copyWith(fontSize: 15)),
                  TextButton(
                    onPressed: () {
                      pushNavigator(
                        context,
                        CategoriesPage(),
                        slideRightToLeft,
                      );
                      cubit.getCategories();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          primaryColor.withOpacity(0.25)),
                      foregroundColor: WidgetStateProperty.all(primaryColor),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side:
                              BorderSide(color: primaryColor.withOpacity(0.4)),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return primaryColor.withOpacity(0.2);
                          }
                          if (states.contains(WidgetState.hovered)) {
                            return primaryColor.withOpacity(0.15);
                          }
                          return null;
                        },
                      ),
                      textStyle: WidgetStateProperty.all(
                        TextStyles.productTitle(context)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    child: Text(
                      S.of(context).seeAllButton,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/failed_icon.png',
                        width: 40, height: 40),
                    const SizedBox(height: 8),
                    Text(S.of(context).failedToLoadCategories),
                  ],
                ),
              ),
            ],
          );
        }

        if (category.isEmpty) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).homePageNewCategories,
                      style:
                          TextStyles.headline2(context).copyWith(fontSize: 15)),
                  TextButton(
                    onPressed: () {
                      pushNavigator(
                        context,
                        CategoriesPage(),
                        slideRightToLeft,
                      );
                      cubit.getCategories();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          primaryColor.withOpacity(0.25)),
                      foregroundColor: WidgetStateProperty.all(primaryColor),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side:
                              BorderSide(color: primaryColor.withOpacity(0.4)),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return primaryColor.withOpacity(0.2);
                          }
                          if (states.contains(WidgetState.hovered)) {
                            return primaryColor.withOpacity(0.15);
                          }
                          return null;
                        },
                      ),
                      textStyle: WidgetStateProperty.all(
                        TextStyles.productTitle(context)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    child: Text(
                      S.of(context).seeAllButton,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/failed_icon.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(S.of(context).noCategoriesFound),
                  ],
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).homePageNewCategories,
                    style:
                        TextStyles.headline2(context).copyWith(fontSize: 15)),
                TextButton(
                  onPressed: () {
                    pushNavigator(
                      context,
                      CategoriesPage(),
                      slideRightToLeft,
                    );
                    cubit.getCategories();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(primaryColor.withOpacity(0.25)),
                    foregroundColor: WidgetStateProperty.all(primaryColor),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: primaryColor.withOpacity(0.4)),
                      ),
                    ),
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return primaryColor.withOpacity(0.2);
                        }
                        if (states.contains(WidgetState.hovered)) {
                          return primaryColor.withOpacity(0.15);
                        }
                        return null;
                      },
                    ),
                    textStyle: WidgetStateProperty.all(
                      TextStyles.productTitle(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  child: Text(
                    S.of(context).seeAllButton,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: screenHeight(context) * .112,
              width: double.infinity,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: category.length > 10 ? 10 : category.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return HomeCategoriesListViewItem(
                    model: category[index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
